# rush 🪶

**Rush** is a command-line utility that lets you run one command on many files using a simple command template syntax. For example, let's say you have a bunch of `.jpeg` files, and you really want them to be named `.jpg` instead. You can do

```sh
rush mv *.jpg '{{name}}.jpg'
```

to accomplish this. If you want to instead convert them to PNGs and tag them with their last-modified dates, you can do

```sh
rush convert *.jpg '{{mdate}}-{{name}}.png'
```

When run, Rush first creates an output file name for each input file using the template string given (you'll find the full list of allowed parameters below). Then, the given command (`mv` or `convert` above) is run on each of the input-output pairs. In other words, running `rush cp *.pdf '{{name}}.{{mdate}}.pdf'` on a few files named `alpha.pdf`, `beta.pdf`, and `gamma.pdf` would run something like

```sh
cp alpha.pdf alpha.2021-04-29.pdf
cp beta.pdf beta.2021-08-12.pdf
cp gamma.pdf gamma.2022-05-04.pdf
```

In this way, Rush makes doing one thing with many files pretty quick and painless. I originally made Rush to help me mass-rename and convert image files, but I've realized since then that this pattern is pretty universally useful. You _can_ do _some_ of the things Rush can do with a `for` loop in Bash, but I always forget the syntax, and it's much harder to get right. So most of the time, I reach for `rush`.

## How do I use it?

Typing `rush --help` gives us the help menu. If you'd rather learn by example, see the [examples](#examples).

```
Rush lets you work on many files at once.

Usage
	rush [cmd] [src-files] [rename-spec] [options]

Options
	--[h]elp    Show this help message
	--stdin     Receive source files list from STDIN
	--[d]ry-run Print all operations, but do not run them
	--[v]erbose Print all executed commands as they are run
	--version   Print version information and exit
	--[f]orce   Overwrite any conflicting files
	--debug     Print CLI arguments for debugging then exit

Template parameters
	path        Full absolute path of the file
	            e.g. "/home/me/image.jpg"
	dir         Directory of the file
	            e.g. "/home/me"
	fullname    Entire file name, including extension
	            e.g. "image.jpg"
	name        File name, without the extension
	            e.g. "image"
	ext         Extension of the file (string after last '.', or
	            empty string if there is no '.')
	            e.g. "jpg"
	i           Integer index of this file when the file list is
	            sorted lexicographically
	            e.g. "10"
	mtime       Last-modified time of the file as a UNIX timestamp
	            e.g. "1651654423"
	mdate       Last-modified date of the file as an ISO date string
	            e.g. "2022-05-04"
	len         Size of the file in bytes
	            e.g. "4094"
```

### Examples

Change extensions on a bunch of files.

```sh
rush mv *.jpeg '{{name}}.jpg'
```

Rename all PDF files to numbers in increasing order.

```sh
rush mv *.pdf '{{i}}.pdf'
```

Add a prefix "secret" to all files, but don't delete the originals.

```sh
rush cp * 'secret-{{fullname}}'
```

Organize files by their last-modified dates into folders and add their last-modified timestamps to their names. (For this to work, the folders must exist beforehand.)

```sh
rush mv * '{{mdate}}/{{name}}-{{mtime}}.{{ext}}'
```

Convert all PNGs to JPGs using [ImageMagick "convert"](https://imagemagick.org/script/convert.php).

```sh
rush convert *.png '{{name}}.jpg'
```

## Install

If you have [Oak](https://oaklang.org) installed, you can build from source (see below). Otherwise, I provide pre-built binaries for macOS and Linux (both x86) on the [releases page](https://github.com/thesephist/rush/releases). Just drop those into your `$PATH` and you should be good to go.

## Build and development

Rush is built with my [Oak programming language](https://oaklang.org), and I manage build tasks with a Makefile.

- `make` or `make build` builds a version of Rush at `./rush`
- `make install` installs Rush to `/usr/local/bin`, in case that's where you like to keep your bins
- `make fmt` or `make f` formats all Oak source files tracked by Git

## Why's it called _Rush_?

It's short, doesn't conflict with any commonly-used CLIs, and felt like a fast... word to me.
