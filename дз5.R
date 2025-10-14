motifs2 <- matrix(c(
  "a", "C", "g", "G", "T", "A", "A", "t", "t", "C", "a", "G",
  "t", "G", "G", "G", "C", "A", "A", "T", "t", "C", "C", "a",
  "A", "C", "G", "t", "t", "A", "A", "t", "t", "C", "G", "G",
  "T", "G", "C", "G", "G", "G", "A", "t", "t", "C", "C", "C",
  "t", "C", "G", "a", "A", "A", "A", "t", "t", "C", "a", "G",
  "A", "C", "G", "G", "C", "G", "A", "a", "t", "T", "C", "C",
  "T", "C", "G", "t", "G", "A", "A", "t", "t", "a", "C", "G",
  "t", "C", "G", "G", "G", "A", "A", "t", "t", "C", "a", "C",
  "A", "G", "G", "G", "T", "A", "A", "t", "t", "C", "C", "G",
  "t", "C", "G", "G", "A", "A", "A", "a", "t", "C", "a", "C"
), nrow = 10, byrow = TRUE)

motifs_upper <- toupper(motifs2)

count_matrix <- apply(motifs_upper, 2, function(col) table(factor(col, levels = c("A", "C", "G", "T"))))

profile_matrix <- apply(motifs_upper, 2, function(x) {
  counts <- table(factor(x, levels = c("A", "C", "G", "T")))
  counts / sum(counts)
})

scoreMotifs <- function(motifs) {
  motifs <- matrix(toupper(motifs), nrow = nrow(motifs))
  sum(apply(motifs, 2, function(col) length(col) - max(table(col))))
}

my_score <-scoreMotifs(motifs2)
print(my_score)


consensus<- apply(profile_matrix, 2, function(col) {
  nucleotides <- c('A', 'C', 'G', 'T')
  nucleotides[which.max(col)]
})
consensus_string<- paste(consensus, collapse='')


nuc_frequency <- function(motifs_upper, index=3){
  freq_table<-table(motifs_upper[, index])
  
  barplot(freq_table,
          main="Частоты нуклеотидов в 3-м столбце",
          col = 'skyblue')
  return(freq_table)
}

motifs_upper <- toupper(motifs2)

nuc_frequency(motifs_upper, 3)