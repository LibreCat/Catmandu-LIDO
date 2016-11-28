package Catmandu::Fix::lido_term;

use Catmandu::Sane;
use Moo;
use Catmandu::Fix::Has;
use Catmandu::Fix::LIDO::Term qw(emit_term);
use Data::Dumper qw(Dumper);

use strict;

with 'Catmandu::Fix::Base';

has path      => ( fix_arg => 1);
has term      => ( fix_arg => 1 );
has conceptid => ( fix_opt => 1 );
has lang      => ( fix_opt => 1 );
has pref      => ( fix_opt => 1 );
has source    => ( fix_opt => 1 );
has type      => ( fix_opt => 1 );

sub emit {
    my ( $self, $fixer ) = @_;

 #   print Dumper $fixer;

    my $perl = '';
    
    $perl .= emit_term($fixer, $fixer->var, $self->path, $self->term, $self->conceptid,
    $self->lang, $self->pref, $self->source, $self->type);

    return $perl;
}

1;

__END__

=pod

=head1 NAME

Catmandu::Fix::lido_term - create a C<term> and C<conceptID> node in a C<path>

=head1 SYNOPSIS

    lido_term(
        path,
        term,
        -conceptid: conceptID,
        -lang: term.lang,
        -pref: term.pref,
        -source: conceptID.source,
        -type: conceptID.type
    )

=head1 DESCRIPTION

Create a node consisting of a C<term> and a C<conceptID> in a C<path>.

=head2 Parameters

=head3 Required parameters

The parameters C<term> and C<path> are required path parameters.

=over

=item C<term>

=item C<path>

=back

=head3 Optional parameters

C<conceptid> is an optional path parameter.

=over

=item C<conceptid>

=back

All other optional parameters are strings.

=over

=item C<lang>

=item C<pref>

=item C<source>

=item C<type>

=back

=head1 EXAMPLE

=head2 Fix

    lido_term(
        category,
        recordList.record.category.value,
        -conceptid: recordList.record.category.id,
        -type: global,
        -source: 'cidoc-crm',
    )

=head2 Result

    <lido:category>
        <lido:conceptID lido:type="global" lido:source="cidoc-crm">123</lido:conceptID>
        <lido:term>Paintings</lido:term>
    </lido:category>
