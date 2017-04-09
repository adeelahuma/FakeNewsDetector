
libs<- c("tm", "SnowballC", "RColorBrewer", "ggplot2", "wordcloud", "biclust", "cluster", "igraph", "fpc", "slam")  
lapply(libs, require, character.only = TRUE)

##function to clean corpus
clean.corpus <- function(corpus){
  
  corpus.tmp <- tm_map(corpus, content_transformer(tolower))
  corpus.tmp <- tm_map(corpus.tmp, removeNumbers)
  
  corpus.tmp <- tm_map(corpus.tmp, removeWords, stopwords("english"))
  
  corpus.tmp <- tm_map(corpus.tmp, removeWords, c('will','said','also','now','even','can','the','still','need','made',
                                                  'another','see','across','take','taking','say','says','use','using',
                                                  'many','used','put','just','like','dont'))
  
  corpus.tmp <- tm_map(corpus.tmp, removePunctuation)
  corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
  #corpus.tmp <- tm_map(corpus.tmp, stemDocument)
  corpus.tmp <- tm_map(corpus.tmp, PlainTextDocument)
  
  return (corpus.tmp)
  
}

##function to get data frame of word frequency
get.data.frame <- function(c_docs){
  
  ##Term Document Matrix
  tdm <- TermDocumentMatrix(c_docs)
  
  tdm1 <- rollup(tdm, 2L, na.rm = TRUE, FUN = sum) ## for large TDM
  
  m <- as.matrix(tdm1)
  v<- sort(row_sums(m,na.rm = TRUE), decreasing = TRUE)
  frame <- data.frame(word =names(v), freq=v)
  return (frame)
}

##create word cloud
create.word.cloud <- function(data_frame, num_of_words){
  set.seed(1234)
  wordcloud(words = data_frame$word, freq = data_frame$freq, min.freq = 1,
            max.words=num_of_words, random.order=FALSE, rot.per=0.35, 
            colors=brewer.pal(8, "Dark2"))
}

##plot word frequency
plot.word.freq <- function(main_label, y_label, data_frame, word_count){
  
  barplot(data_frame[1:word_count,]$freq, las=2, names.arg = data_frame[1:word_count,]$word, col="blue", 
          main=main_label, ylab = y_label)
}

