<p align="center">
<img src="./logo.png">
</p>

# Ocampiler
>Ocampiler é um compilador escrito em Ocaml para a [linguagem de programação IMP](https://github.com/ChristianoBraga/BPLC/blob/master/examples/imp/README.md).

Este trabalho é uma tarefa do curso de [Compiladores](http://www2.ic.uff.br/~cbraga/pmwiki/pmwiki.php/Classes/Compiladores) ministrado pelo professor [Chistiano Braga](http://www2.ic.uff.br/~cbraga/pmwiki/pmwiki.php/Main/AffiliationAndResearchInterests) no primeiro semestre de 2019 na Universidade Federal Fluminense. 

Ocampiler usa Ocamllex and Ocamlyacc.

# Instalação
```
cd src
make install
```
Fará com que o Opam seja instalado na sua máquina, gerenciando as dependências usadas pelo Ocampiler.
Esse comando também gerará o compilador, Ocampiler, na pasta src.

# Uso e opções na linha de comando
```
ocampiler -f <impfile> [-s | -a | -t ]
-s : Exibe o código fonte.
-a : Exibe a árvore síntática.
-t : Exibe o traço completo de execução do autômato.
```
