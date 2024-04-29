# Load necessary libraries
library(ggplot2)

# Subset data for HR chicks, SR chicks, and hens
subset_data <- meta[meta$group %in% c("HR1", "HR2", "HR3", "SR"), ]

# Calculate alpha diversity indices (e.g., Faith's PD, Pielou's Evenness, Shannon Entropy) for each group
alpha_diversity_hr1 <- subset_data[subset_data$group == "HR1", c("faith_pd", "pielou_evenness", "shannon_entropy")]
alpha_diversity_hr2 <- subset_data[subset_data$group == "HR2", c("faith_pd", "pielou_evenness", "shannon_entropy")]
alpha_diversity_hr3 <- subset_data[subset_data$group == "HR3", c("faith_pd", "pielou_evenness", "shannon_entropy")]
alpha_diversity_sr <- subset_data[subset_data$group == "SR", c("faith_pd", "pielou_evenness", "shannon_entropy")]

# Combine alpha diversity indices into a single data frame
alpha_diversity <- rbind(
  cbind(alpha_diversity_hr1, Group = "HR1"),
  cbind(alpha_diversity_hr2, Group = "HR2"),
  cbind(alpha_diversity_hr3, Group = "HR3"),
  cbind(alpha_diversity_sr, Group = "SR")
)

# Reshape the data for plotting
alpha_diversity_long <- reshape2::melt(alpha_diversity, id.vars = "Group", variable.name = "AlphaDiversity", value.name = "Value")

# Create boxplots
ggplot(alpha_diversity_long, aes(x = AlphaDiversity, y = Value, fill = Group)) +
  geom_boxplot() +
  labs(title = "Alpha Diversity of Gut Microbiota",
       x = "Alpha Diversity Index",
       y = "Value") +
  theme_minimal() +
  scale_fill_manual(values = c("#1b9e77", "#d95f02", "#7570b3", "#e7298a"))  # Custom colors for HR1, HR2, HR3, and SR groups



ggplot(subset_data, aes(x = group, y = faith_pd, fill = group)) +
  geom_boxplot() +
  labs(title = "Faith's PD Alpha Diversity of Gut Microbiota",
       x = "Group",
       y = "Faith's PD") +
  theme_minimal() +
  scale_fill_manual(values = c("#1b9e77", "#d95f02", "#7570b3", "#e7298a"))  # Custom colors for HR1, HR2, HR3, and SR groups
