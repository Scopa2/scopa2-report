# latexmkrc configuration

# Use pdflatex (default)
$pdf_mode = 1;

# Custom rule for bibtex to run the prettifier first
$bibtex = 'ruby bibtex_prettifier.rb && bibtex %O %S';

# Cleanup options
$clean_ext = 'pdfsync synctex.gz synctex.gz(busy) fdb_latexmk fls aux log out toc bbl blg';
