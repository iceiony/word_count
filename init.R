library('pryr')
library('plyr')
library('dplyr')
library('reshape2')
library('ggplot2')
library('parallel')
library('tictoc')
library('ptw')
library('zoo')

# source all functions from mlp_functions folder
lapply(list.files('functions', '[.]R$', full.names = T), source)

elapsed <- function(msg){
    toc()
    message(msg)
    tic()
}

start_date <- as.Date('2015-06-25')
