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
p3:
	git pull origin p3
	git checkout p3
	$(MAKE) run

p2:
	git pull origin p2
	git checkout p2
	$(MAKE) run

p1:
	git pull origin p1
	git checkout p1
	$(MAKE) run

fat:
	./ocampiler -f examples/fatorial.imp --stats -t

fib:
	./ocampiler -f examples/fibonacci.imp --stats -t

help:         
	##               Options of make command
    ## 
	## 
	##   p1        : switch to branch p1
	##   p2        : switch to branch p2
	##   p3        : switch to branch p3
	##   clear     : clear the actual build
	##   install   : install ocaml and all of its dependences
	##   run       : build the project 

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
