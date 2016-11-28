package Catmandu::Fix::lido_classification;

use Data::Dumper qw(Dumper);

use Catmandu::Sane;
use Moo;
use Catmandu::Fix::Has;
use Catmandu::Fix::LIDO::Utility qw(walk declare_source);

use Catmandu::Fix::LIDO::Term qw(emit_term);

use strict;

#https://librecatproject.wordpress.com/2014/03/26/create-a-fixer-part-2/

with 'Catmandu::Fix::Base';

has object_work_type        => (fix_arg => 1);
has classification          => (fix_arg => 1);
has object_work_type_id     => (fix_opt => 1);
has classification_id       => (fix_opt => 1);
has object_work_type_type   => (fix_opt => 1);
has object_work_type_source => (fix_opt => 1);
has classification_type     => (fix_opt => 1);
has classification_source   => (fix_opt => 1);
has lang                    => (fix_opt => 1);

sub emit {
    my ($self, $fixer) = @_;

    my $path = ['descriptiveMetadata', 'objectClassificationWrap'];
    my $perl = '';

    $perl .= $fixer->emit_create_path(
        $fixer->var,
        $path,
        sub {
            my $r_root = shift;
            my $r_code = '';

            ##
            # classification
            if (defined($self->classification)) {
                $r_code .= emit_term($fixer, $r_root, 'classificationWrap.classification',
                            $self->classification, $self->classification_id, $self->lang, 'preferred', $self->classification_source,
                            $self->classification_type);
            }

            ##
            # objectWorkType
            if (defined($self->object_work_type)) {
                $r_code .= emit_term($fixer, $r_root, 'objectWorkTypeWrap.objectWorkType',
                            $self->object_work_type, $self->object_work_type_id, $self->lang, undef, $self->object_work_type_source,
                            $self->object_work_type_type);
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

Catmandu::Fix::lido_classification - create an C<objectClassificationWrap>.

=head1 SYNOPSIS

    lido_classification(
        object_work_type,
        classification,
        -object_work_type_id: objectWorkType.conceptID,
        -classification_id: classification.conceptID,
        -object_work_type_type: objectWorkType.type,
        -object_work_type_source: objectWorkType.source,
        -classification_type: classification.type,
        -classification_source: classification_source,
        -lang: objectClassificationWrap.*.lang
    )

=head1 DESCRIPTION

C<lido_classification> will create a C<objectClassificationWrap> containing both the C<classificationWrap.classification> and the C<objectWorkTypeWrap.objectWorkType>.

=head2 Parameters

=head3 Required parameters

C<object_work_type> and C<classification> are required path parameters.

=over

=item C<object_work_type>

=item C<classification>

=back

=head3 Optional parameters

C<object_work_type_id> and C<classification_id> are optional path parameters. All other parameters are strings. Note that C<lang> is repeated on both C<objectWorkType> and C<classification>.

=over

=item C<object_work_type_id>

=item C<classification_id>

=back

=over

=item C<object_work_type_type>

=item C<object_work_type_source>

=item C<classification_type>

=item C<classification_source>

=item C<lang>

=back

=head1 EXAMPLE

=head2 Fix

    lido_classification (
        recordList.record.object_name.value,
        recordList.record.object_cat.value,
        -object_work_type_id: recordList.record.object_name.id,
        -classification_id: recordList.record.object_cat.id,
        -object_work_type_type: global,
        -object_work_type_source: adlib,
        -classification_type: global,
        -classification_source: adlib,
        -lang: nl
    )

=head2 Result

    <lido:descriptiveMetadata>
        <lido:objectClassificationWrap>
            <lido:objectWorkTypeWrap>
                <lido:objectWorkType>
                    <lido:conceptID lido:type="global" lido:source="adlib">123</lido:conceptID>
                    <lido:term xml:lang="nl">olieverfschilderij</lido:term>
                </lido:objectWorkType>
            </lido:objectWorkTypeWrap>
            <lido:classificationWrap>
                <lido:classification>
                    <lido:conceptID lido:pref="preferred" lido:type="global" lido:source="adlib">123</lido:conceptID>
                    <lido:term lido:pref="preferred" xml:lang="nl">Schilderijen</lido:term>
                </lido:classification>
            </lido:classificationWrap>
        </lido:objectClassificationWrap>
    </lido:descriptiveMetadata>
