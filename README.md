<p align="center">
<img src="./logo.png">
</p>

# Ocampiler
>Ocampiler é um compilador escrito em Ocaml para a [linguagem de programação IMP](https://github.com/ChristianoBraga/BPLC/blob/master/examples/imp/README.md).

Este trabalho é uma tarefa do curso de [Compiladores](http://www2.ic.uff.br/~cbraga/pmwiki/pmwiki.php/Classes/Compiladores) ministrado pelo professor [Chistiano Braga](http://www2.ic.uff.br/~cbraga/pmwiki/pmwiki.php/Main/AffiliationAndResearchInterests) no primeiro semestre de 2019 na Universidade Federal Fluminense feito por [Felipe Assad](https://github.com/assadfelipe), [Jorge Felipe](https://github.com/junglejf) e [Thiago Augusto](https://github.com/sevontheedge).

Ocampiler usa Ocamllex and Ocamlyacc que é a alternativa em Ocaml das ferramentas lex (um gerador de analisador léxico) e yacc (um gerador de analisador sintático LALR). 

# Instalação
```
cd src
make install
```
Fará com que o Opam seja instalado na sua máquina, gerenciando as dependências usadas pelo Ocampiler.
Esse comando também gerará o compilador, Ocampiler, na pasta src. 
O comando de instalação do opam poderá levar alguns minutos, aprecie seu café enquanto isso. 

# Uso e Opções da Linha de Comando
```
ocampiler -f <impfile> [-s | -a | -t | --state n | --stats]
-s : Exibe o código fonte.
-a : Exibe a árvore síntática.
-t : Exibe o traço completo de execução do autômato.
--state n : Exibe o n-ésimo estado de execução do autômato
--stats: Exibe o número de passos e o tempo de execução do autômato.
```
