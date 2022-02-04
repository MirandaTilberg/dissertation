# PURPOSE: Code to compile the thesis in RStudio using TeX package `chapterbib` 

# DESCRIPTION: The ISU journal-style dissertation template uses package 
#   `chapterbib` to allow different bibliographies for each chapter. 
#   Chapterbib requires that chapters are added to the main .tex file using an 
#   "\include" statement, and BibTeX must be run on each chapter.

#   Full order for thesis.tex: pdfLaTeX, BibTeX, pdfLaTeX, pdfLaTeX

# INSTRUCTIONS:
#   1. Compile thesis.Rnw with RStudio's "Compile PDF" button
#   2. Run this script
#   3. Check that PDF was compiled correctly; each chapter's Reference section
#      should contain only the references cited in that chapter.

# NOTE: File paths assume that your working directory is the top level directory

# NOTE: You will need a copy of master_bib.bib in two places: 1) the top-level
#       directory and 2) the Body folder. To avoid manual errors from copying,
#       save master_bib.bib to the top-level directory and create a symbolic
#       link (like a shortcut) to the file in the Body folder:

if(!file.exists("./Body/master_bib.bib")){
  file.symlink(from = "./master_bib.bib", 
               to   = "./Body/master_bib.bib")
}

# NOTE: This code was developed in an RStudio IDE that can't run pdfLaTeX
#       automatically when clicking "Compile PDF". If your machine can run 
#       pdfLaTeX the first time, you may need to adjust this process.

# run pdfLaTeX
system2("pdflatex", shQuote("thesis.tex"))

# run BibTeX on each chapter
system2("bibtex", shQuote("Body/ch1_main.aux")) 
system2("bibtex", shQuote("Body/ch2_main.aux"))
system2("bibtex", shQuote("Body/ch3_main.aux"))
system2("bibtex", shQuote("Body/ch4_main.aux"))
system2("bibtex", shQuote("Body/ch5_main.aux"))
system2("bibtex", shQuote("Body/ch6_future_and_conclusions.aux"))

# run pdfLaTeX twice
system2("pdflatex", shQuote("thesis.tex"))
system2("pdflatex", shQuote("thesis.tex"))


# # clean Body folder (optional)
# rules <- c(".tex", ".aux", ".bbl", ".blg")
# file.remove(list.files(path = "./Body",
#                        pattern = paste0('\\',rules ,'$', collapse = '|'),
#                        full.names = TRUE))
