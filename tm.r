library(tm)
library(tmcn)
library(Rwordseg)
library(wordcloud)

d.corpus <- Corpus(DirSource("data"), list(language = NA))                  # read data
d.corpus <- tm_map(d.corpus, content_transformer(removePunctuation))        # remove punctuation
d.corpus <- tm_map(d.corpus, content_transformer(removeNumbers))            # remove numbers
d.corpus <- tm_map(d.corpus, content_transformer(function(word) gsub("[A-Za-z0-9]", "", word)))

# words <- readLines("http://wubi.sogou.com/dict/download_txt.php?id=9182") # ptt corpus
# words <- toTrad(words)
# insertWords(words)                                                        # tagging

d.corpus <- tm_map(d.corpus, content_transformer(segmentCN), nature = TRUE) # stemming

# d.corpus <- tm_map(d.corpus, function(sentence) {                         # feature selection
#     noun <- lapply(sentence, function(w) {
#         w[names(w) == "n"]
#     })
#     print(noun)
#     unlist(noun)
# })

d.corpus <- Corpus(VectorSource(d.corpus))

myStopWords <- c(stopwordsCN(), "編輯", "時間", "標題", "發信", "實業", "作者")
d.corpus <- tm_map(d.corpus, content_transformer(removeWords), myStopWords)

tdm = as.matrix(TermDocumentMatrix(d.corpus))
#print(tdm)

m1 <- as.matrix(tdm)
v <- sort(rowSums(m1), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)
wordcloud(d$word, d$freq, min.freq = 4, random.order = F, ordered.colors = F, 
          colors = rainbow(length(row.names(m1))))
#inspect(d.corpus)