TEX:=pdftex
LATEX:=pdflatex
LATEXFLAGS:=-shell-escape
MAKEIDX:=makeindex

PKG:=bibletext
DOC:=$(PKG).pdf
STY:=$(PKG).sty
TEX:=$(PKG).tex
TARBALL:=$(PKG).tar.gz

DEPS:=$(wildcard exmp/*)

all: $(STY) $(DOC) $(TARBALL)

$(TARBALL): $(STY) $(TEX) $(DOC) README.md LICENSE
	cp $< $<.tmp
	tar czv --transform 's!^!$(PKG)/!' -f $@ $^
	mv $<.tmp $<

%.pdf: %.tex %.sty
	cp $< $<.tmp
	$(LATEX) $(LATEXFLAGS) $< && \
		$(LATEX) $(LATEXFLAGS) $< && \
		$(LATEX) $(LATEXFLAGS) $<
	mv $<.tmp $<

clean:
	$(RM) -v $(addprefix $(PKG).,aux glo gls hd idx ilg ind log out tmp toc)

distclean: clean
	$(RM) -v $(addprefix $(PKG).,ins pdf sty) $(TARBALL)

.PHONY: clean distclean
