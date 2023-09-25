library(readtext)
library(dplyr)
library(markovchain)

# Directory containing the .txt files
path <- "/songs/"

# List all .txt files in the directory
txt_files <- list.files(path, pattern = "\\.txt$", full.names = TRUE)

# Read and combine the content of all .txt files
combined_text <- character()
for (file in txt_files) {
  file_content <- readLines(file)
  combined_text <- c(combined_text, file_content)
}

# Combine the text into a single string
combined_text <- paste(combined_text, collapse = "\n")

# Clean the text by removing punctuation and line breaks
clean_text <- gsub("[[:punct:]]", replacement = "", combined_text)
clean_text <- gsub("\\n", replacement = " ", clean_text)

# Split the cleaned text into a list of words
text_list <- unlist(strsplit(clean_text, " "))

# Train a Markov chain model
set.seed(1234)
model <- markovchainFit(text_list)

# Generate a sequence of words from the Markov chain
generated_text <- markovchainSequence(n = 100, markovchain = model$estimate)

# Print the generated text
cat(paste(generated_text, collapse = " "))
