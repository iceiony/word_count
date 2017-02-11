library('parallel')
library('pryr')
library('plyr')
library('dplyr')
library('stringr')
library('NLP')
library('openNLP')

source('process_file.R')

files <- list.files('./in', '[.]txt$', full.names = T)
doc_words <- mclapply(files, process_file)
doc_words <- do.call(rbind,doc_words)

