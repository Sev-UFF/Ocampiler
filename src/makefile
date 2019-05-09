# The Caml compilers. You may have to add various -I options.

CAMLC = ocamlc
CAMLDEP = ocamldep
CAMLLEX = ocamllex
CAMLYACC = ocamlyacc

# Lex stuff
LEXSOURCES = lexer.mll
LEXGENERATED = lexer.ml

# Yacc stuff
YACCSOURCES = parser.mly
YACCGENERATED = parser.mli parser.ml

GENERATED = $(LEXGENERATED) $(YACCGENERATED)

# Caml sources
SOURCES = util.ml pi.ml $(GENERATED) automaton.ml  main.ml 
# Caml object files to link
OBJS = util.cmo pi.cmo lexer.cmo parser.cmo automaton.cmo  main.cmo

# Name of executable file to generate
EXEC = ocampiler

# This part should be generic
# Don't forget to create (touch) the file ./.depend at first use.

#install package dependencies
install:
	sudo add-apt-repository ppa:avsm/ppa
	sudo apt update
	sudo apt-get install ocaml opam
	sudo opam switch create 4.07.1 4.07.1
	sudo opam switch remove system
	sudo opam init
	$(MAKE) update
	$(MAKE) run

update:
	eval 'opam env'

# Building the world
run: depend $(EXEC)

repair:
	sudo add-apt-repository ppa:avsm/ppa
	sudo apt update
	sudo apt install opam
	$(MAKE) update
	$(MAKE) run
	opam init --yes
	sudo opam instal ocaml-base-compiler
	$(MAKE) clear
	$(MAKE) run


	


# Clean up
clear:
	rm -f *.cm[io] *.cmx *~ .*~ #*#
	rm -f $(GENERATED)
	rm -f $(EXEC)

# Dependencies
depend: $(SOURCES) $(GENERATED) $(LEXSOURCES) $(YACCSOURCES)
	$(CAMLDEP) *.mli *.ml > .depend


$(EXEC): $(GENERATED) $(OBJS)
	$(CAMLC) $(OBJS) -o $(EXEC)

%.ml: %.mll
	$(CAMLLEX) $<

%.mli: %.mly
	$(CAMLYACC) $<

%.ml: %.mly
	$(CAMLYACC) $<

%.cmi: %.mli
	$(CAMLC) -c $<

%.cmo: %.ml
	$(CAMLC) -c $<


include .depend