package Catmandu::Fix::lido_inscription;

use Catmandu::Sane;
use Moo;
use Catmandu::Fix::Has;
use Catmandu::Fix::LIDO::Utility qw(walk declare_source);
use Catmandu::Fix::LIDO::DescriptiveNote qw(emit_descriptive_note);
use Catmandu::Fix::LIDO::Value qw(emit_base_value);

use strict;

#https://librecatproject.wordpress.com/2014/03/26/create-a-fixer-part-2/

use Data::Dumper qw(Dumper);

with 'Catmandu::Fix::Base';

has transcription => (fix_opt => 1);
has descriptive_note => (fix_opt => 1);
has type => (fix_opt => 1);
has label => (fix_opt => 1);
has lang => (fix_opt => 1);

sub emit {
    my ($self, $fixer) = @_;

    my $perl = '';

    $perl .= $fixer->emit_create_path(
        $fixer->var,
        ['descriptiveMetadata', 'objectIdentificationWrap', 'inscriptionsWrap', 'inscriptions'],
        sub {
            my $r_root = shift;
            my $r_code = '';

            ##
            # inscriptionTranscription
            if (defined($self->transcription)) {
                $r_code .= emit_base_value($fixer, $r_root, '$append.inscriptionTranscription', $self->transcription, $self->lang, undef, $self->label, $self->type);
            }

            ##
            # inscriptionDescription.descriptiveNoteValue
            if (defined($self->descriptive_note)) {
                $r_code .= emit_descriptive_note($fixer, $r_root, '$last.inscriptionDescription', $self->descriptive_note, $self->lang, $self->label);
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

Catmandu::Fix::lido_inscription - create a C<inscriptions> node

=head1 SYNOPSIS

    lido_inscription(
        -transcription: inscriptionTranscription,
        -descriptive_note: inscriptionDescription,
        -type: inscriptionTranscription.type,
        -label: inscriptionTranscription.label & descriptiveNote.label,
        -lang: inscriptionDescription.lang & inscriptionTranscription.lang
    )

=head1 DESCRIPTION

Create a C<inscriptions> node with a transcription and a descriptive note.

=head2 Parameters

=head3 Required parameters

This fix has no required parameters.

=head3 Optional parameters

C<transcription> and C<descriptive_note> are optional path parameters.

=over

=item C<transcription>

=item C<descriptive_note>

=back

All other optional parameters are strings.

=over

=item C<type>

=item C<label>

=item C<lang>

=back

=head1 EXAMPLE

=head2 Fix

    lido_inscription(
        -transcription: recordList.record.transcription,
        -descriptive_note: recordList.record.transcription_description,
        -label: inscription,
        -lang: nl
    )

=head2 Result

    <lido:descriptiveMetadata>
        <lido:objectIdentificationWrap>
            <lido:inscriptionsWrap>
                <lido:inscriptions>
                    <lido:inscriptionTranscription xml:lang="nl" lido:label="inscription">Een generieke beschrijving.</lido:inscriptionTranscription>
                    <lido:inscriptionDescription>
                        <lido:descriptiveNoteValue xml:lang="nl" lido:label="inscription">Een generieke beschrijving.</lido:descriptiveNoteValue>
                    </lido:inscriptionDescription>
                </lido:inscriptions>
            </lido:inscriptionsWrap>
        </lido:objectIdentificationWrap>
      </lido:descriptiveMetadata>
