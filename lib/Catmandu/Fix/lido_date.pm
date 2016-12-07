package Catmandu::Fix::lido_date;

use Catmandu::Sane;
use Moo;
use Catmandu::Fix::Has;
use Catmandu::Fix::LIDO::Value qw(emit_base_value emit_simple_value);
use Catmandu::Fix::LIDO::Utility qw(declare_source split_path);
use Data::Dumper qw(Dumper);

use strict;

our $VERSION = '0.06';

with 'Catmandu::Fix::Base';

has path => (fix_arg => 1);
has earliest_date => (fix_opt => 1);
has earliest_date_type => (fix_opt => 1);
has latest_date => (fix_opt => 1);
has latest_date_type => (fix_opt => 1);

sub emit {
    my ($self, $fixer) = @_;
    my $perl = '';
    my $new_path = split_path($self->path);

    my $last = pop @$new_path;

    my $earliest_path = ['earliestDate'];
    my $latest_path = ['latestDate'];

    my $f_earliest = $fixer->generate_var();
    my $f_earliest_type = $fixer->generate_var();
    my $f_latest = $fixer->generate_var();
    my $f_latest_type = $fixer->generate_var();

    $perl .= "my ${f_latest};";
    $perl .= declare_source($fixer, $self->latest_date, $f_latest);
    $perl .= "my ${f_latest_type};";
    $perl .= declare_source($fixer, $self->latest_date_type, $f_latest_type);

    ##
    # Bug #4
    if ($last eq '$append' || $last eq '$prepend' || $last eq '$last' || $last eq '$first') {
        unshift @$earliest_path, $last;
        if ($last eq '$prepend' || $last eq '$first') {
            unshift @$latest_path, '$first';
        } else {
            unshift @$latest_path, '$last';
        }
    } else {
        push @$new_path, $last;
    }

    $perl .= $fixer->emit_create_path(
        $fixer->var,
        $new_path,
        sub {
            my $r_root = shift;
            my $r_code = '';

            ##
            # earliestDate
            # $fixer, $root, $path, $value, $lang, $pref, $label, $type, $is_string
            if (defined($self->earliest_date)) {
                $r_code .= "my ${f_earliest};";
                $r_code .= declare_source($fixer, $self->earliest_date, $f_earliest);
                if (defined($self->earliest_date_type)) {
                    $r_code .= "my ${f_earliest_type};";
                    $r_code .= declare_source($fixer, $self->earliest_date_type, $f_earliest_type);
                }
                $r_code .= $fixer->emit_create_path(
                    $r_root,
                    $earliest_path,
                    sub {
                        my $e_root = shift;
                        my $e_code = '';

                        $e_code .= "${e_root} = {";
                        
                        if (defined($self->earliest_date_type)) {
                            $e_code .= "'type' => ${f_earliest_type},";
                        }

                        $e_code .= "'_' => ${f_earliest}";

                        $e_code .= "};";

                        return $e_code;
                    }
                );
            }

            ##
            # latestDate
            if (defined($self->latest_date)) {
                $r_code .= "my ${f_latest};";
                $r_code .= declare_source($fixer, $self->latest_date, $f_latest);
                if (defined($self->latest_date_type)) {
                    $r_code .= "my ${f_latest_type};";
                    $r_code .= declare_source($fixer, $self->latest_date_type, $f_latest_type);
                }
                $r_code .= $fixer->emit_create_path(
                    $r_root,
                    $latest_path,
                    sub {
                        my $l_root = shift;
                        my $l_code = '';

                        $l_code .= "${l_root} = {";
                        
                        if (defined($self->latest_date_type)) {
                            $l_code .= "'type' => ${f_latest_type},";
                        }

                        $l_code .= "'_' => ${f_latest}";

                        $l_code .= "};";

                        return $l_code;
                    }
                );
            }

            return $r_code;
        }
    );

    return $perl;
}

1;

__END__

=pod

=head1 NAME

Catmandu::Fix::lido_date - create a generic date component in C<path>

=head1 SYNOPSIS

    lido_date(
        path,
        -earliest_date: earliestDate,
        -latest_date: latestDate
    )

=head1 DESCRIPTION

Creates a generic date component consisting of C<latestDate> and C<earliestDate> in a C<path>.

=head2 Parameters

=head3 Required parameters

C<path> is a required path parameter.

=over

=item C<path>

=back

=head3 Optional parameters

All optional parameters are paths.

=over

=item C<earliest_date>

=item C<latest_date>

=back

=head1 EXAMPLE

=head2 Fix

    lido_date(
        descriptiveMetadata.eventWrap.eventSet.$last.event.eventDate.date,
        -earliest_date: recordList.record.production_date_start,
        -latest_date: recordList.record.production_date_end
    )

=head2 Result

    <lido:descriptiveMetadata>
        <lido:eventWrap>
            <lido:eventSet>
                <lido:event>
                    <lido:eventDate>
                        <lido:date>
                            <lido:earliestDate>1812</lido:earliestDate>
                            <lido:latestDate>1813</lido:latestDate>
                        </lido:date>
                    </lido:eventDate>
                </lido:event>
            </lido:eventSet>
        </lido:eventWrap>
    </lido:descriptiveMetadata>
