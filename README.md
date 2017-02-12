Instructions
============

Code was tested on R v3.2.2

* To install needed dependencies run 
```bash
Rscript install_dependencies.R
```
If install fails for the rJava package, reconfigure the R java binding
```bash
sudo R CMD javareconf
```

* Place input documents in `./in/` 

* Output generated in `./out/` after running 
```bash
Rscript count_words.R
```
Two csv files are produced :
- sentences.csv -> contains sentence id's and unique sentences from documents 
- top_words.csv -> contains the words, counts, list of documents, and list of seantence id's

Notes
=====
The openNLP package uses a java implementation. 
If case of any Java errors when running the script, reconfigure R's java binding with the above command.

