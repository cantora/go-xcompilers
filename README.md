# go-xcompilers

very simple and short makefile for building go cross
compilers from source.

## building
run `make` to build the cross compilers. if you want to
install the go binary somewhere you should modify the
`INSTALL_PREFIX` variable in the makefile and then run
`make install`.

## alternatives
here are some more complex alternatives:

 * [go-crosscompile](https://github.com/c9s/go-crosscompile)
 * [gox](https://github.com/mitchellh/gox)
 * [goxc](https://github.com/laher/goxc)

