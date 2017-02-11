extract_sentences <- function(doc){
    sent_ann <- Maxent_Sent_Token_Annotator()
    doc_ann  <- annotate(doc, sent_ann)
    doc[doc_ann]
}

process_file <- function(doc){
    sentences <- readChar(doc, file.info(doc)$size) %>%
                 as.String() %>%
                 extract_sentences() %>%
                 as.factor()

    words <- mclapply(sentences,
                 function(s){
                     words <- as.character(s) %>%
                              str_extract_all("['$£,\\w/]+") %>%
                              unlist() 
                     words <- as.data.frame(words, stringsAsFactors = F)

                     cbind(words, sentence = s)
                 }) %>% bind_rows()

    words <- words %>% 
               group_by(words) %>%
               summarise(count = n(), 
                         sentences = list(sentence))
    cbind(words, document = doc)
}

