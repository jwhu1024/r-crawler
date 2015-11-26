library(tm)
library(tmcn)
library(Rwordseg)
library(wordcloud)

# setwd("/home/lester/Desktop/test")

d.corpus <- VCorpus(DirSource("data"), readerControl = list(language="UTF-8"))
d.corpus <- tm_map(d.corpus, content_transformer(removePunctuation))
d.corpus <- tm_map(d.corpus, content_transformer(removeNumbers))

# tdm <- TermDocumentMatrix(d.corpus, control = list())
# inspect(tdm[])
# stop()

installDict("ptt.dic", "ptt", dicttype = "text")

d.corpus <- tm_map(d.corpus, content_transformer(segmentCN), nature = TRUE)
d.corpus <- Corpus(VectorSource(d.corpus))

myStopWords <- c(toTrad(stopwordsCN()), "編輯", "時間", "看板car標題", "發信", "實業", "作者", "發信站", "文章網址")
d.corpus <- tm_map(d.corpus, content_transformer(removeWords), myStopWords)

tdm <- TermDocumentMatrix(d.corpus, control = list())

# debug
#tmp <- as.matrix(TermDocumentMatrix(d.corpus, control = list()))
#print(tmp)
#stop()
# 前兩篇文章的前10個關鍵字
#inspect(tdm[1:10, 1:2])

# wordcloud
m1 <- as.matrix(tdm)
v <- sort(rowSums(m1), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)
wordcloud(d$word, d$freq, min.freq = 10, random.order = F, random.color = T,
          ordered.colors = F, colors = rainbow(length(row.names(m1))))

#d.dtm <- DocumentTermMatrix(d.corpus, control = list())
#inspect(d.dtm[])