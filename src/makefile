# The Caml compilers.
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
SOURCES = util.ml pi.ml $(GENERATED) automatonType.ml automaton.ml   main.ml 
# Caml object files to link
OBJS = util.cmo pi.cmo lexer.cmo parser.cmo automatonType.cmo automaton.cmo  main.cmo
# Library files not linked by default
LINKS = unix.cma

# Name of executable file to generate
EXEC = ocampiler

#install package dependencies
install:
	sudo apt install gcc 
	sudo add-apt-repository ppa:avsm/ppa
	sudo apt update
	sudo apt install opam
	opam init --yes
	sudo opam install ocaml-base-compiler
	sudo apt install ocaml-nox
	$(MAKE) clear
	$(MAKE) run

# Building the world
run:  depend $(EXEC)

# Clean up
clear:
	rm -f *.cm[io] *.cmx *~ .*~ #*#
	rm -f $(GENERATED)
	rm -f $(EXEC)


p2:
	git pull origin p2
	git checkout p2
	$(MAKE) run

p1:
	git pull origin p1
	git checkout p1
	$(MAKE) run

test:
	./ocampiler -f examples/aexp.imp -s -a -t |more
	./ocampiler -f examples/bexp.imp -s -a -t |more
	./ocampiler -f examples/fatorial.imp -s -a -t |more
	./ocampiler -f examples/fibonacci.imp -s -a -t |more
	./ocampiler -f examples/assign.imp -s -a -t |more
	./ocampiler -f examples/assign2.imp -s -a -t |more
	./ocampiler -f examples/deref.imp -s -t 
	
	

# Dependencies
depend: $(SOURCES) $(GENERATED) $(LEXSOURCES) $(YACCSOURCES)
	$(CAMLDEP) *.mli *.ml > .depend


$(EXEC): $(GENERATED) $(OBJS)
	eval $$(opam env) && $(CAMLC) $(LINKS) $(OBJS) -o $(EXEC)

%.ml: %.mll
	$(CAMLLEX) $<

%.mli: %.mly
	$(CAMLYACC) $<

%.ml: %.mly
	$(CAMLYACC) $<

%.cmi: %.mli
	eval $$(opam env) &&  $(CAMLC) -c $<

%.cmo: %.ml
	eval $$(opam env) &&  $(CAMLC) -c $<


include .depend
