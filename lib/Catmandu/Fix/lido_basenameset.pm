package Catmandu::Fix::lido_basenameset;

use Catmandu::Sane;
use Moo;
use Catmandu::Fix::Has;
use Catmandu::Fix::LIDO::Utility qw(walk);
use Catmandu::Fix::LIDO::Nameset qw(emit_nameset);

use strict;

#https://librecatproject.wordpress.com/2014/03/26/create-a-fixer-part-2/

use Data::Dumper qw(Dumper);

with 'Catmandu::Fix::Base';

has path => (fix_arg => 1);
has value => (fix_arg => 1);
has value_pref => (fix_opt => 1);
has value_lang => (fix_opt => 1);
has source => (fix_opt => 1);
has source_lang => (fix_opt => 1) ;

sub emit {
    my ($self, $fixer) = @_;

    my $perl = '';

#$fixer, $path, $appellation_value, $appellation_value_lang, 
#$appellation_value_type, $appellation_value_pref, $source_appellation, $source_appellation_lang
    $perl .= emit_nameset($fixer, $fixer->var, $self->path, $self->value, $self->value_lang, undef, $self->value_pref,
    $self->source, $self->source_lang);

    return $perl;
}

1;

__END__

=pod

=head1 NAME

Catmandu::Fix::lido_basenameset - Create a basic nameset in a C<path>

=head1 SYNOPSIS

    lido_basenameset (
        path,
        value,
        -value_pref: appellationValue.pref,
        -value_lang: appellationValue.lang,
        -source: sourceAppellation,
        -source_lang: sourceAppellation.lang
    )

=head1 DESCRIPTION

C<lido_basenameset> creates a basic LIDO node that contains both C<appellationValue> and C<sourceAppellation> at a specified C<path>.

=head2 Parameters

=head3 Required parameters

C<path> and C<value> are required parameters that must be a path.

=over

=item C<path>

=item C<value> (appellationValue)

=back

=head3 Optional parameters

C<source> must be a path, all the other parameters are strings.

=over

=item C<source> (sourceAppellation)

=back

=over

=item C<value_pref>

=item C<value_lang>

=item C<source_lang>

=back

=head1 EXAMPLE

=head2 Fix

    lido_basenameset(
        descriptiveMetadata.objectIdentificationWrap.titleWrap.titleSet,
        recordList.record.title.value,
        -value_lang: nl,
        -value_pref: preferred,
        -source: recordList.record.title.source,
        -source_lang: nl
    )

=head2 Result

    <lido:descriptiveMetadata>
        <lido:objectIdentificationWrap>
            <lido:titleWrap>
                <lido:titleSet>
                    <lido:appellationValue lido:pref="preferred" xml:lang="nl">Naderend onweer</lido:appellationValue>
                    <lido:sourceAppellation xml:lang="nl">MSK Gent</lido:sourceAppellation>
                </lido:titleSet>
            </lido:titleWrap>
        </lido:objectIdentificationWrap>
    </lido:descriptiveMetadata>
