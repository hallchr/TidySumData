#Working with Text


library(tidyverse)
#install.packages('janitor')
library(janitor)
#install.packages('skimr')
library(skimr)
library(stringr)
#install.packages('htmlwidgets')
library(htmlwidgets)


#Beyond working with single strings and string literals, sometimes the information you’re analyzing is a whole body of text.
#Tidy text used to analyze whole bodies of text - like books, etc!

#Tidy Text

# install.packages("tidytext")
library(tidytext)

carrots <- c("They say that carrots are good for your eyes",
             "They swear that they improve your sight",
             "But I'm seein' worse than I did last night -",
             "You think maybe I ain't usin' em right?")

carrots

#put in tibble for tidyness
library(tibble)
text_df <- tibble(line = 1:4, text = carrots)

text_df

#tokenization turning each row into a single word
text_df %>% 
  unnest_tokens(word, text) #word is splitting into one-word, text is selecting column of text_df to use.

#Sentiment Analysis

#Often, once you’ve tokenized your dataset, there is an analysis you want to do - a question you want to answer. Sometimes, 
#this involves wanting to measure the sentiment of a piece by looking at the emotional content of the words in that piece.

#To do this, the analyst must have access to or create a lexicon, a dictionary with the sentiment of common words. There 
#are three single word-based lexicons available within the tidytext package: afinn, bing, loughran and nrc. Each differs 
#in how they categorize sentiment, and to get a sense of how words are categorized in any of these lexicon, you can use the 
#get_sentiments() function.

library(textdata)
# be sure textdata is installed
#install.packages("textdata", repos = 'http://cran.us.r-project.org')

# see information stored in NRC lexicon
get_sentiments('nrc')

text_df %>% 
  unnest_tokens(word, text) %>% 
  inner_join(get_sentiments('nrc'))
## Joining, by = "word"

text_df %>%
  unnest_tokens(word, text) %>%
  inner_join(get_sentiments('nrc')) %>%
  count(sentiment, sort = TRUE)

#Word and document frequency

#Beyond sentiment analysis, analysts of text are often interested in quantifying what a document is about.

#A document’s inverse document frequency (idf) weights each term by its frequency in a collection of documents. Those words 
#that are quite common in a set of documents are down-weighted. The weights for words that are less common are increased. By 
#combining idf with term frequency (tf) (through multiplication), words that are common and unique to that document (relative 
#to the collection of documents) stand out.

#so looking at relative weights are important because no one cares how many words such as "and" or "or" there are....

library(tibble)
invitation <- c("If you are a dreamer, come in,",
                "If you are a dreamer, a wisher, a liar", 
                "A hope-er, a pray-er, a magic bean buyer…",
                "If you’re a pretender, come sit by my fire",
                "For we have some flax-golden tales to spin.",
                "Come in!",
                "Come in!")

invitation <- tibble(line = 1:7, text = invitation, title = "Invitation")

invitation

masks <- c("She had blue skin.", 
           "And so did he.", 
           "He kept it hid", 
           "And so did she.", 
           "They searched for blue", 
           "Their whole life through",
           "Then passed right by—", 
           "And never knew")

masks <- tibble(line = 1:8, text = masks, title = "Masks")

masks

# add title to carrots poem
carrots <- text_df %>% mutate(title = "Carrots")

# combine all three poems into a tidy data frame
poems <- bind_rows(carrots, invitation, masks)

# count number of times word appwars within each text
poem_words <- poems %>%
  unnest_tokens(word, text) %>%
  count(title, word, sort = TRUE)

# count total number of words in each poem
total_words <- poem_words %>% 
  group_by(title) %>% 
  summarize(total = sum(n))
## `summarise()` ungrouping output (override with `.groups` argument)
# combine data frames
poem_words <- left_join(poem_words, total_words)
## Joining, by = "title"
poem_words

library(ggplot2)
# visualize frequency / total words in poem
ggplot(poem_words, aes(n/total, fill = title)) +
  geom_histogram(show.legend = FALSE, bins = 5) +
  facet_wrap(~title, ncol = 3, scales = "free_y")

#look at frequency of words relative to document length
freq_by_rank <- poem_words %>% 
  group_by(title) %>% 
  mutate(rank = row_number(), 
         `term frequency` = n/total)

#look at relative frequency while taking into account common words!

poem_words <- poem_words %>%
  bind_tf_idf(word, title, n)

# sort ascending
poem_words %>%
  arrange(tf_idf)

poem_words %>%
  arrange(desc(tf_idf))

#We can summarize these tf-idf results by visualizing the words with the highest tf-idf in each of these poems:

poem_words %>%
  arrange(desc(tf_idf)) %>%
  mutate(word = factor(word, levels = rev(unique(word)))) %>% 
  group_by(title) %>% 
  top_n(3) %>% 
  ungroup() %>%
  ggplot(aes(word, tf_idf, fill = title)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf-idf") +
  facet_wrap(~title, ncol = 3, scales = "free") +
  coord_flip()