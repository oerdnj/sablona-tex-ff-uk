bib_files = Sury.pdf
files = $(bib_files)

common = document_footer.tex document_header.tex header.tex hyphenation.tex titlepage_header.tex titlepage_footer.tex

TEX=xelatex -8bit
BIB=bibtex
BATCH=-interaction=batchmode

all: $(files)

view:
	open $(files)

%.bbl: %.tex Sury.bib
	INPUT=$<; \
	( $(TEX) $(BATCH) $${INPUT%.tex} || $(TEX) $${INPUT%.tex} ) && \
	( $(BIB) $${INPUT%.tex} )

$(nobib_files): %.pdf: %.tex $(common)
	INPUT=$<; \
	( $(TEX) $(BATCH) $${INPUT%.tex} || $(TEX) $${INPUT%.tex} ) && \
	( $(TEX) $(BATCH) $${INPUT%.tex} || $(TEX) $${INPUT%.tex} )

$(bib_files): %.pdf: %.tex %.bbl hyphenation.tex $(common)
	INPUT=$<; \
	( $(TEX) $(BATCH) $${INPUT%.tex} || $(TEX) $${INPUT%.tex} ) && \
	( $(TEX) $(BATCH) $${INPUT%.tex} || $(TEX) $${INPUT%.tex} )

clean:
	rm -f *.aux *.bbl *.blg *.log *.toc *.pdf *.ttt *.fff *.out
