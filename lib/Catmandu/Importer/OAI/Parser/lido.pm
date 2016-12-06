package Catmandu::Importer::OAI::Parser::lido;

use Catmandu::Sane;
use Moo;
use Catmandu;
use Catmandu::Util;
use LIDO::XML;
use JSON;

with 'Catmandu::Logger';

has 'lido'      => (is => 'lazy');

sub _build_lido {
    return Lido::XML->new;
}

sub parse {
    my ($self,$dom) = @_;

    return undef unless defined $dom;

    my $xml  = $dom->toString;
    my $perl = { error => 1 };

    eval {
        $perl    = $self->lido->parse($xml);
    };
    if ($@) {
        $perl = { error => $@ };
        $self->log->error($@);
        $self->log->error("Failed to parse: $xml");
    }

    { _metadata => $perl };
}

1;
