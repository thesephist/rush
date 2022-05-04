# rush 🪶

**Rush** is a command-line utility that lets you run one command on many files using a simple command template syntax.

## Examples

Change extensions on a bunch of files

```sh
rush mv *.jpeg '{{name}}.jpg'
```

Rename all PDF files to numbers

```
rush mv *.pdf '{{i}}.pdf'
```

Add a prefix "secret" to all files, but don't delete originals

```
rush cp * 'secret-{{fullname}}'
```

Add last-modified times to photos and put them in folders by dates

```
rush mv * '{{mdate}}/{{name}}-{{mtime}}.{{ext}}'
```

Convert all PNGs to JPGs using ImageMagick "convert"

```
rush convert *.png '{{name}}.jpg'
```

## Build and development


