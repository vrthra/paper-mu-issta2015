all: build/paper.pdf

build/data/mu.rda: data/mu.rda
	mkdir -p build/data
	cp data-mu-fse/set/*.rda build/data/

build/paper.pdf: src/paper.Rnw build/data/mu.rda
	cp etc/* build
	cp src/*.Rnw build
	cp src/*.bib build
	curl  http://web.engr.oregonstate.edu/~gopinath/fse/Mutsel_1.0.tar.gz -o build/data/Mutsel_1.0.tar.gz
	cd build/data; cat *.tar.gz| gzip -dc | tar -xvpf - ; R CMD INSTALL Mutsel
	cd build; Rscript -e "require(knitr); knit('paper.Rnw', encoding='UTF-8');"
	cd build; ../bin/latexmk -pdf acm_sigproc.tex

clean:
	rm -rf build

