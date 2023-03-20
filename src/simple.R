library(reticulate)

use_condaenv("pandera-nyhackr")

schema = import("src.schema")
print(schema$Schema)

r_data <- data.frame(
    item = c("apple", "orange", "orange"),
    price = c(0.5, 0.75, NaN)
)

# print(schema$Schema$validate(schema$python_data))
print(schema$Schema$validate(r_data))
