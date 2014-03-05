all: build/paper.pdf

build/paper.pdf: src/paper.Rnw build/data/Mutsel_1.0.tar.gz
	cp etc/* build
	cp src/*.Rnw build
	cp src/*.bib build
	cp src/*.tex build
	cd build; Rscript -e "require(knitr); knit('paper.Rnw', encoding='UTF-8');"
	cd build; ../bin/latexmk -pdf acm_sigproc.tex

build/data/Mutsel_1.0.tar.gz: | build build/data
	curl  http://web.engr.oregonstate.edu/~gopinath/fse/Mutsel_1.0.tar.gz -o build/data/Mutsel_1.0.tar.gz
	cd build/data; cat *.tar.gz| gzip -dc | tar -xvpf - ; R CMD INSTALL Mutsel

build build/data:
	mkdir -p build/data

clean:
	mkdir -p .tmp
	mv -f build .tmp/$(date)
	rm -rf .tmp

