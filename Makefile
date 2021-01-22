.POSIX:
.SUFFIXES:
include config.mk
HAREC:=HARECACHE=$(HARECACHE) $(HAREC)

hare:

.SUFFIXES: .ha .ssa .s .o
.ssa.s:
	@printf 'QBE\t$@\n'
	@$(QBE) -o $@ $<

.s.o:
	@printf 'AS\t$@\n'
	@$(AS) -o $@ $<

include stdlib.mk

hare_srcs=\
	main.ha

$(HARECACHE)/hare.ssa: $(hare_srcs)
	@printf 'HAREC\t$@\n'
	@$(HAREC) -o $@ $(hare_srcs)

hare_deps=\
	$(stdlib_io)

hare: $(hare_deps) $(stdlib_rt) $(stdlib_start) $(HARECACHE)/hare.o
	@printf 'LD\t$@\n'
	@$(LD) -o $@ $(stdlib_start) $(HARECACHE)/hare.o $(stdlib_rt) $(hare_deps)

clean:
	false # TODO

all: hare

.PHONY: all clean
