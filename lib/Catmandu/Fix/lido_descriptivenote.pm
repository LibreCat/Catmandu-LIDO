package Catmandu::Fix::lido_descriptivenote;

use Catmandu::Sane;
use Moo;
use Catmandu::Fix::Has;
use Catmandu::Fix::LIDO::Utility qw(walk declare_source);
use Catmandu::Fix::LIDO::DescriptiveNote qw(emit_descriptive_note);

use strict;

#https://librecatproject.wordpress.com/2014/03/26/create-a-fixer-part-2/

use Data::Dumper qw(Dumper);

with 'Catmandu::Fix::Base';

has path => (fix_arg => 1);
has value => (fix_arg => 1);
has lang => (fix_opt => 1);
has label => (fix_opt => 1);

sub emit {
    my ($self, $fixer) = @_;

    my $perl = '';

    my $new_path = $fixer->split_path($self->path);

    $perl .= $fixer->emit_create_path(
        $fixer->var,
        $new_path,
        sub {
            my $r_root = shift;
            my $r_code = '';

            $r_code .= emit_descriptive_note($fixer, $r_root, '', $self->value, $self->lang, $self->label);

            return $r_code;
        }
    );

    return $perl;
}

1;

__END__

=pod

=head1 NAME

Catmandu::Fix::lido_descriptivenote - create a C<descriptiveNoteValue> in a C<path>

=head1 SYNOPSIS

    lido_descriptivenote(
        path,
        value,
        -lang: descriptiveNoteValue.lang,
        -label: descriptiveNoteValue.label
    )

=head1 DESCRIPTION

Creates a C<descriptiveNoteValue> in a C<path>.

=head2 Parameters

=head3 Required parameters

C<path> and C<value> are required path parameters.

=over

=item C<path>

=item C<value>

=back

=head3 Optional parameters

All optional parameters are strings.

=over

=item C<lang>

=item C<label>

=back

=head1 EXAMPLE

=head2 Fix

    lido_descriptivenote(
        descriptiveMetadata.eventWrap.eventSet.$last.event.eventDescriptionSet,
        recordList.record.creation_desc,
        -lang: nl
    )

=head2 Result
    <lido:descriptiveMetadata>
        <lido:eventWrap>
            <lido:eventSet>
                <lido:event>
                    <lido:eventDescriptionSet>
                        <lido:descriptiveNoteValue xml:lang="nl">Een generieke beschrijving.</lido:descriptiveNoteValue>
                    </lido:eventDescriptionSet>
                </lido:event>
            </lido:eventSet>
        </lido:eventWrap>
    </lido:descriptiveMetadata>
