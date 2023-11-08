if (!require(IRanges)) {
  install.packages("IRanges")
}

# First, create a column to flag Ozone level < 25
Asturias_Argentina$group <- ifelse(Asturias_Argentina$`Ozone level` < 25, 0, 1)

# Use rle() to find sequences of 0's (Ozone level < 25)
rle_res <- rle(Asturias_Argentina$group == 0)
zero_pos <- cumsum(rle_res$lengths)
three_zero_pos <- zero_pos[rle_res$values & rle_res$lengths >= 3] 

Asturias_Argentina$group_tem <- Asturias_Argentina$group
temp <- 1
for(i in three_zero_pos[-length(three_zero_pos)]){
  temp <- temp +1
  end_one_next <- three_zero_pos[which(three_zero_pos==i)+1]
  begin_one_next <- zero_pos[which(zero_pos==end_one_next)-1]
  Asturias_Argentina$group_tem[(i+1):begin_one_next][(Asturias_Argentina$group[(i+1):begin_one_next]==1)] <- temp
}
last_pos <- (end_one_next+1):length(Asturias_Argentina$group_tem)
Asturias_Argentina$group_tem[last_pos][(Asturias_Argentina$group[last_pos]==1)] <- temp+1

write.csv(Asturias_Argentina,file="C:/Users/danhe/OneDrive/Documents/2/asturias_Argentina_trans.csv")


# Now, we need to "inflate" these sequences back to the original data frame size
Asturias_Argentina$group_count <- inverse.rle(list(lengths = rle_res$lengths, values = seq_along(rle_res$lengths)))

# Finally, update groups where group_count > 3
Asturias_Argentina$group[Asturias_Argentina$group_count > 3] <- Asturias_Argentina$group[Asturias_Argentina$group_count > 3] + 1

# You can remove group_count if you don't need it
Asturias_Argentina$group_count <- NULL