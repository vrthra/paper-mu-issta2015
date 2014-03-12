things=$(wildcard src/*.Rnw src/*.bib etc/*.tex)

all: build/acm_sigproc.pdf

build/acm_sigproc.pdf: $(things) build/data/Mutsel_1.0.tar.gz
	rm -rf build/fig
	cp -r fig build
	cp etc/* build
	cp src/*.Rnw build
	cp src/*.bib build
	cp src/*.tex build
	cd build; Rscript -e "require(knitr); knit('paper.Rnw', encoding='UTF-8');"
	cd build; ../bin/latexmk -pdf acm_sigproc.tex
	cp build/acm_sigproc.pdf /tmp

build/data/Mutsel_1.0.tar.gz: | build build/data
	rm -rf build/cache
	make instr

instr: | build build/data
	curl  http://web.engr.oregonstate.edu/~gopinath/fse/Mutsel_1.0.tar.gz -o build/data/Mutsel_1.0.tar.gz
	cd build/data; cat *.tar.gz| gzip -dc | tar -xvpf - ; R CMD INSTALL Mutsel

build build/data:
	mkdir -p build/data

clean:
	rm -rf build/*

