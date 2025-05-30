.ONESHELL:

param=$(filter-out $@,$(MAKECMDGOALS))
script_path=$(dirname "$0")
paper_id:=$(notdir $(patsubst %/,%,$(dir $(shell pwd))))


echo "paper id: $(paper_id)"

default:
	@echo "choose a target: pdf or html"


html:
	bash tex2html.sh
	cp ./build/html/review.html ../publish/joas-review-$(paper_id).html

pdf:
	pdflatex -synctex=1 -shell-escape review.tex 
	biber review
	pdflatex -synctex=1 -shell-escape review.tex
	cp review.pdf ../publish/joas-review-$(paper_id).pdf
	rm -f *.aux *.bbl *.blg *.bcf *.fls *.fdb_latexmk *.idx *.ilg *.ind *.log *.out *.run.xml *.toc

clean:
	rm -f *.aux *.bbl *.blg *.bcf *.fls *.fdb_latexmk *.idx *.ilg *.ind *.log *.out *.run.xml *.toc
	find build/html/ -type f -not -name "empty" -delete
	find build/pdf/ -type f -not -name "empty" -delete
	find tmp/ -type f -delete


%:
	@:
