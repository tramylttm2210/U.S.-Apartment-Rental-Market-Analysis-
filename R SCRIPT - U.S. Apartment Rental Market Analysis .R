
# Load necessary packages
library(ggplot2)

# Read the CSV file using ISO-8859-1 encoding to fix character errors
df <- read.csv("apartments_for_rent_classified_10K.csv", 
               sep = ";", 
               fileEncoding = "ISO-8859-1")

# Drop the 'has_photo' column as it is not analytically relevant
df$has_photo <- NULL

# Clean price_display column: remove $ and commas, extract numeric values
df$price_display_clean_text <- gsub("[$,]", "", df$price_display)
df$price_display_clean_text <- gsub("[^0-9\.]+", "", df$price_display_clean_text)
df$price_display_clean <- as.numeric(df$price_display_clean_text)

# Remove rows where price conversion failed
df <- df[!is.na(df$price_display_clean), ]

# Convert bedroom, bathroom, square_feet to numeric
df$bedrooms <- as.numeric(df$bedrooms)
df$bathrooms <- as.numeric(df$bathrooms)
df$square_feet <- as.numeric(df$square_feet)

# Remove rows with missing critical numerical or location fields
df <- df[complete.cases(df[, c("price_display_clean", "bedrooms", "bathrooms", "square_feet", "state", "cityname")]), ]

# Clean and format state and cityname
df$state <- toupper(trimws(df$state))
df$cityname <- tools::toTitleCase(tolower(trimws(df$cityname)))

# Keep only rows that do NOT contain "null" in any of the specified columns
cols_to_check <- c(
  "id", "category", "title", "body", "amenities", "bathrooms", "bedrooms",
  "currency", "fee", "pets_allowed", "price", "price_display", "price_type",
  "square_feet", "address", "cityname", "state", "latitude", "longitude",
  "source", "time", "price_display_clean_text", "price_display_clean"
)
df <- df[!apply(df[ , cols_to_check], 1, function(row) any(row == "null")), ]

# Visualizations

# --- Continuous Data ---

# Histogram: Rental Price
ggplot(df, aes(x = price_display_clean)) +
  geom_histogram(fill = "steelblue", color = "black", bins = 50) +
  labs(title = "Rental Price Distribution", x = "Price (USD)", y = "Count") +
  xlim(0, 5000)

# --- Discrete Data ---

# Bar chart: Bedroom Frequency
ggplot(df, aes(x = as.factor(bedrooms))) +
  geom_bar(fill = "darkorange") +
  labs(title = "Frequency of Bedroom Counts", x = "Number of Bedrooms", y = "Count")

# Boxplot: Price by Bedrooms
ggplot(df, aes(x = as.factor(bedrooms), y = price_display_clean)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Price by Bedroom Count", x = "Number of Bedrooms", y = "Price (USD)") +
  ylim(0, 5000)

# --- Categorical Data ---

# Bar chart: Top 5 States by Average Price
top_states <- aggregate(price_display_clean ~ state, data = df, FUN = mean)
top_states <- top_states[order(-top_states$price_display_clean), ][1:5, ]

ggplot(top_states, aes(x = reorder(state, -price_display_clean), y = price_display_clean)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Top 5 States by Average Rental Price", x = "State", y = "Average Price (USD)")

# Get variables
group1_cols <- c("square_feet", "bedrooms", "bathrooms")
df_clean <- df[complete.cases(df[, c("price_display_clean", "bedrooms", "bathrooms", "square_feet", "pets_allowed")]), ]
# Descriptive statistics
group1_stats <- data.frame(
  Mean = sapply(df_clean[group1_cols], mean),
  SD = sapply(df_clean[group1_cols], sd),
  Count = sapply(df_clean[group1_cols], function(x) sum(!is.na(x))),
  Min = sapply(df_clean[group1_cols], min),
  Median = sapply(df_clean[group1_cols], median),
  Max = sapply(df_clean[group1_cols], max),
  Range = sapply(df_clean[group1_cols], function(x) max(x) - min(x))
)

print(group1_stats)


library(dplyr)


group2_stats <- df_clean %>%
  group_by(state) %>%
  summarise(
    Mean = mean(price_display_clean),
    Median = median(price_display_clean),
    Count = n()
  ) %>%
  arrange(desc(Mean))

