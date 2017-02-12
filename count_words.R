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


all_sent <- levels(doc_words$document) %>%
            lapply(function(doc_name){
                idx <- first(which(doc_words$document == doc_name)) 
                levels(doc_words$sentences[[idx]])
            }) %>% 
            unlist() %>% 
            unique() %>%
            as.factor() %>%
            sort()
                    
#set same factor to all sentences
doc_words$sentences <- doc_words$sentences %>% 
                       lapply(function(sentences){
                           factor(sentences, levels = all_sent)
                       })

#aggregate word count across documents
doc_words <- doc_words %>%
             group_by(words) %>%
             summarise(count = sum(count),
                       document = list(document),
                       sentences = list(unlist(sentences))) %>%
             arrange(-count)

#output sentences to separate file
all_sent <- data.frame(id = as.numeric(all_sent), sentence = levels(all_sent))
write.table(all_sent, './out/sentences.csv', sep = ',' , row.names = F )


 
#output word counts
doc_words <- doc_words %>%
             rowwise() %>%
             mutate(document  = paste(document, collapse = ', '),
                    sentences = paste(as.numeric(sentences), collapse = ', '))

write.table(doc_words, './out/top_words.csv', sep = ',', row.names = F)
