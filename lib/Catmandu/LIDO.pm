package Catmandu::LIDO;

our $VERSION = '0.10';

1;

__END__

=encoding utf8

=head1 NAME

Catmandu::LIDO - Modules for handling LIDO data within the Catmandu framework

=head1 SYNOPSIS

Command line client C<catmandu>:

  catmandu convert LIDO to JSON --fix lido.fix < data/lido.xml > data/lido.json

  catmandu convert JSON to LIDO --fix lido.fix < data/lido.json > data/lido.xml

See documentation of modules for more examples.

=head1 DESCRIPTION

Catmandu::LIDO contains modules to handle LIDO, an 
XML Schema for contributing content to cultural heritage repositories.

=head1 AVAILABLE MODULES

=over

=item L<Catmandu::Exporter::LIDO>

Serialize LIDO data

=item L<Catmandu::Importer::LIDO>

Parse LIDO data

=back

=head2 Custom Fixes

=over

=item L<Catmandu::Fix::lido_actor>

=item L<Catmandu::Fix::lido_baseid>

=item L<Catmandu::Fix::lido_baseid>

=item L<Catmandu::Fix::lido_basename>

=item L<Catmandu::Fix::lido_basevalue>

=item L<Catmandu::Fix::lido_classification>

=item L<Catmandu::Fix::lido_date>

=item L<Catmandu::Fix::lido_descriptivenote>

=item L<Catmandu::Fix::lido_inscription>

=item L<Catmandu::Fix::lido_objectmeasurements>

=item L<Catmandu::Fix::lido_term>

=back

=head1 SEE ALSO

This module is based on L<Catmandu>, L<Lido::XML> and L<XML::Compile>

=head1 AUTHORS

=over

=item Patrick Hochstenbach, C<< patrick.hochstenbach at ugent.be >>

=item Matthias Vandermaesen, C<< matthias.vandermaesen at vlaamsekunstcollectie.be >>

=item Pieter De Praetere, C<< pieter at packed.be >>

=back

=head1 CONTRIBUTORS

=over

=item Patrick Hochstenbach, C<< patrick.hochstenbach at ugent.be >>

=item Pieter De Praetere, C<< pieter at packed.be >>

=item Matthias Vandermaesen, C<< matthias.vandermaesen at vlaamsekunstcollectie.be >>

=back

=head1 COPYRIGHT AND LICENSE

The Perl software is copyright (c) 2016 by PACKED vzw, VKC vzw and Patrick Hochstenbach.
This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.

=encoding utf8

=cut