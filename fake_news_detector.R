###
## Exploratory Data Analysis of Fake vs Real news articles
## For fake and real news articles following code plots: 
##    a) word frequency
##    b) word cloud 
##    c) TBD
###

source("R/corpusAnalyzer.R")

fake_news_dir_path <-"./data/fake_news"
real_news_dir_path <-"./data/real_news"



#### plots for fake news ####

docs_fake <- Corpus(DirSource(fake_news_dir_path))

c_docs_fake <- clean.corpus(docs_fake)
f_frame <- get.data.frame(c_docs_fake)
plot.word.freq("Most Occuring words in Fake News Documents", "Word frequencies", f_frame, 30)
create.word.cloud(f_frame,200)

#### plots for real news ####

docs_real <- Corpus(DirSource(real_news_dir_path))

c_docs_real <- clean.corpus(docs_real)
r_frame <- get.data.frame(c_docs_real)
plot.word.freq("Most Occuring words in Real News Documents", "Word frequencies", r_frame, 30)
create.word.cloud(r_frame,200)