# NAME
[![Build Status](https://travis-ci.org/librecat/Catmandu-LIDO.svg?branch=master)](https://travis-ci.org/librecat/Catmandu-LIDO)

Catmandu::LIDO - Modules for handling LIDO data within the Catmandu framework

# SYNOPSIS

Command line client `catmandu`:

```
    catmandu convert LIDO to JSON --fix lido.fix < data/lido.xml > data/lido.json
```

```
    catmandu convert JSON to LIDO --fix lido.fix < data/lido.json > data/lido.xml
````

See documentation of modules for more examples.

# DESCRIPTION

Catmandu::LIDO contains modules to handle LIDO, an 
XML Schema for contributing content to cultural heritage repositories.

# AVAILABLE MODULES

- [Catmandu::Exporter::LIDO](https://metacpan.org/pod/Catmandu::Exporter::LIDO)

    Serialize LIDO data

- [Catmandu::Importer::LIDO](https://metacpan.org/pod/Catmandu::Importer::LIDO)

    Parse LIDO data

## Custom Fixes

- [Catmandu::Fix::lido\_actor](https://metacpan.org/pod/Catmandu::Fix::lido_actor)
- [Catmandu::Fix::lido\_baseid](https://metacpan.org/pod/Catmandu::Fix::lido_baseid)
- [Catmandu::Fix::lido\_baseid](https://metacpan.org/pod/Catmandu::Fix::lido_baseid)
- [Catmandu::Fix::lido\_basename](https://metacpan.org/pod/Catmandu::Fix::lido_basename)
- [Catmandu::Fix::lido\_basevalue](https://metacpan.org/pod/Catmandu::Fix::lido_basevalue)
- [Catmandu::Fix::lido\_classification](https://metacpan.org/pod/Catmandu::Fix::lido_classification)
- [Catmandu::Fix::lido\_date](https://metacpan.org/pod/Catmandu::Fix::lido_date)
- [Catmandu::Fix::lido\_descriptivenote](https://metacpan.org/pod/Catmandu::Fix::lido_descriptivenote)
- [Catmandu::Fix::lido\_inscription](https://metacpan.org/pod/Catmandu::Fix::lido_inscription)
- [Catmandu::Fix::lido\_objectmeasurements](https://metacpan.org/pod/Catmandu::Fix::lido_objectmeasurements)
- [Catmandu::Fix::lido\_term](https://metacpan.org/pod/Catmandu::Fix::lido_term)

# SEE ALSO

This module is based on [Catmandu](https://metacpan.org/pod/Catmandu), [Lido::XML](https://metacpan.org/pod/Lido::XML) and [XML::Compile](https://metacpan.org/pod/XML::Compile)

# AUTHORS

- Patrick Hochstenbach, `patrick.hochstenbach at ugent.be`
- Matthias Vandermaesen, `matthias.vandermaesen at vlaamsekunstcollectie.be`
- Pieter De Praetere, `pieter at packed.be`

# CONTRIBUTORS

- Patrick Hochstenbach, `patrick.hochstenbach at ugent.be`
- Pieter De Praetere, `pieter at packed.be`
- Matthias Vandermaesen, `matthias.vandermaesen at vlaamsekunstcollectie.be`

# COPYRIGHT AND LICENSE

The Perl software is copyright (c) 2016 by PACKED vzw, VKC vzw and Patrick Hochstenbach.
This is free software; you can redistribute it and/or modify it under the same terms as the Perl 5 programming language system itself.
