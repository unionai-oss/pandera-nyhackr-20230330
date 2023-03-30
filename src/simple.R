library(reticulate)
library(dplyr)

use_condaenv("pandera-nyhackr")

schema <- import("src.schema")
print(schema$Schema)

r_data <- data.frame(
    item = c("apple", "orange", "orange"),
    price = c(0.5, 0.75, NaN)
)

# validate the python data
print(schema$Schema$validate(schema$python_data))

# validate an R dataframe
print(schema$Schema$validate(r_data))

# invalid data
invalid_data <- data.frame(
    item = c("apple", "orange", "orangee"),
    price = c(-1.0, 0.75, NaN)
)

# catch the python exception
validated_data <- tryCatch({
    schema$Schema$validate(invalid_data, lazy=TRUE)
}, error=function(err) {
    exception <<- attr(py_last_error(), "exception")
    return(NULL)
})

# get failed rows don't forget the 0- to 1-based index conversion!
failure_cases <- py_to_r(exception$failure_cases)
failed_rows <- as.character(failure_cases$index + 1)

# filter the data to only include valid rows
filtered_data <- invalid_data |> filter(!(rownames(invalid_data) %in% failed_rows))

print(failure_cases)
print(filtered_data)

# synthesize data
print(schema$Schema$example(size = as.integer(5)))

# which is useful for unit testing!
process_data <- function(data, in_stock) {
    schema$Schema$validate(data, lazy=TRUE) |>
        mutate(in_stock=in_stock)
}

test_process_data <- function() {
    mock_data <- schema$Schema$example(size = as.integer(5))
    output <- process_data(mock_data, TRUE)
    print(output)
}

test_process_data()
