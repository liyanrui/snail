# Snail

The **snail** package is a MetaPost module within the ConTeXt LMTX environment, designed for creating flowcharts and similar procedural graphics.

## Installation

Assuming you have properly installed the ConTeXt LMTX environment following the [installation instructions](https://wiki.contextgarden.net/Introduction/Installation) on the ConTeXt wiki, and that your ConTeXt LMTX installation directory is `/opt/context`, proceed with the installation as follows:

```console
$ git clone https://github.com/liyanrui/snail
$ cd snail
$ SNAILPATH=/opt/context/tex/texmf-local/tex/context/third/snail
$ mkdir -p $SNAILPATH
$ cp t-snail.mkxl $SNAIPATH
$ context --generate
```


