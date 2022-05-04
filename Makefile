all: build

# build CLI
build:
	oak pack --entry main.oak -o rush
b: build

# install CLI
install:
	oak pack --entry main.oak -o /usr/local/bin/rush

# format changed Oak source
fmt:
	oak fmt --changes --fix
f: fmt

