INSTALL_PREFIX      = $(HOME)
INSTALL_EXECS       = go gofmt
INSTALL_TARGETS     = $(foreach bin,$(INSTALL_EXECS),$(INSTALL_PREFIX)/bin/$(bin))

.PHONY: all
all: go/bin/go

define xcompiler-target
PLATFORMS += go/bin/$(1)_$(2)/go
go/bin/$(1)_$(2)/go: go/src/make.bash
	cd go/src && GOOS=$(1) GOARCH=$(2) ./make.bash --no-clean 2>&1
endef

xcompiler  = $(eval $(call xcompiler-target,$(1),$(2)))

$(call xcompiler,darwin,386)
$(call xcompiler,darwin,amd64)

$(call xcompiler,freebsd,386)
$(call xcompiler,freebsd,amd64)
$(call xcompiler,freebsd,arm)

$(call xcompiler,linux,386)
$(call xcompiler,linux,amd64)
$(call xcompiler,linux,arm)

$(call xcompiler,windows,386)
$(call xcompiler,windows,amd64)

all: $(PLATFORMS)

.PHONY: install
install: $(INSTALL_TARGETS)

define install-target
$$(INSTALL_PREFIX)/bin/$(1): go/bin/$(1)
	mkdir -p $$(dir $$@) \
		&& cd $$(dir $$@) \
		&& ln -sf $$(CURDIR)/$$<
endef
$(foreach x,$(INSTALL_EXECS),$(eval $(call install-target,$(x))))

go/bin/go: go/src/all.bash
	cd go/src && ./all.bash

go/src/make.bash: go/README
go/src/all.bash: go/README

go/README:
	hg clone 'https://code.google.com/p/go'
