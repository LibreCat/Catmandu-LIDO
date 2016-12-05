# NAME

Catmandu::LIDO - Modules for handling LIDO data within the Catmandu framework

# SYNOPSIS

Command line client `catmandu`:

    catmandu convert LIDO to JSON < data/lido.xml > data/lido.json

    catmandu convert JSON to LIDO < data/lido.json > data/lido.xml

See documentation of modules for more examples.

# DESCRIPTION

Catmandu::LIDO contains modules to handle Lido an 
XML Schema for Contributing Content to Cultural Heritage Repositories.

# AVAILABLE MODULES

- [Catmandu::Exporter::LIDO](https://metacpan.org/pod/Catmandu::Exporter::LIDO)

    Serialize LIDO data

- [Catmandu::Importer::LIDO](https://metacpan.org/pod/Catmandu::Importer::LIDO)

    Parse LIDO data

- [Catmandu::Fix::LIDO](https://metacpan.org/pod/Catmandu::Fix::LIDO)

    LIDO-specific fixes (see [FIX.md](https://github.com/LibreCat/Catmandu-LIDO/blob/master/FIX.md) for more information).

# SEE ALSO

This module is based on [Catmandu](https://metacpan.org/pod/Catmandu), [Lido::XML](https://metacpan.org/pod/Lido::XML) and [XML::Compile](https://metacpan.org/pod/XML::Compile)

# COPYRIGHT AND LICENSE

PACKED vzw, 2016 -
Patrick Hochstenbach, 2016 -

This is free software; you can redistribute it and/or modify it under the same
terms as the Perl 5 programming language system itself.
