all: build/paper.pdf

build/data/mu.rda: data/mu.rda
	mkdir -p build/data
	cp data/mu.rda build/data/mu.rda

build/paper.pdf: src/paper.Rnw build/data/mu.rda
	cp etc/* build
	cp src/*.Rnw build
	cp src/*.bib build
	cd build; Rscript -e "require(knitr); knit('paper.Rnw', encoding='UTF-8');"
	cd build; ../bin/latexmk -pdf acm_sigproc.tex

clean:
	rm -rf build

