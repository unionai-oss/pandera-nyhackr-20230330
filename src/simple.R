library(reticulate)

use_condaenv("pandera-nyhackr")

schema = import("src.schema")
print(schema$Schema)

r_data <- data.frame(
    item = c("apple", "orange", "orange"),
    price = c(0.5, 0.75, NaN)
)

# validate the python data
print(schema$Schema$validate(schema$python_data))

# validate an R dataframe
print(schema$Schema$validate(r_data))

# synthesize data
print(schema$Schema$example(size = as.integer(5)))
