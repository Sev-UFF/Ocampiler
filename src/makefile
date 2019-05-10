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

#install package dependencies
install:
	sudo apt install gcc
	sudo add-apt-repository ppa:avsm/ppa
	sudo apt update
	sudo apt install opam
	opam init --yes
	sudo opam instal ocaml-base-compiler
	#opam init --yes
	sudo apt install ocaml-nox
	#sudo apt install ocaml
	#eval 'opam env' #eval $(opam env)
	#ev
	#clear
	#run

# Building the world
run: ev depend $(EXEC)

ev:
	eval $(opam env)

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
