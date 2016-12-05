package Catmandu::LIDO;

our $VERSION = '0.05';

1;

__END__

=encoding utf8

=head1 NAME

Catmandu::LIDO - Modules for handling LIDO data within the Catmandu framework

=head1 SYNOPSIS

Command line client C<catmandu>:

  catmandu convert LIDO to JSON < data/lido.xml > data/lido.json

  catmandu convert JSON to LIDO < data/lido.json > data/lido.xml

See documentation of modules for more examples.

=head1 DESCRIPTION

Catmandu::LIDO contains modules to handle Lido an 
XML Schema for Contributing Content to Cultural Heritage Repositories.

=head1 AVAILABLE MODULES

=over

=item L<Catmandu::Exporter::LIDO>

Serialize LIDO data

=item L<Catmandu::Importer::LIDO>

Parse LIDO data

=back

=head1 SEE ALSO

This module is based on L<Catmandu>, L<Lido::XML> and L<XML::Compile>

=head1 COPYRIGHT AND LICENSE

Patrick Hochstenbach, 2016 -

This is free software; you can redistribute it and/or modify it under the same
terms as the Perl 5 programming language system itself.

=cut