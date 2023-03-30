import numpy as np
import pandas as pd
import pandera as pa
from pandera.typing import Series


class Schema(pa.DataFrameModel):
    item: Series[str] = pa.Field(isin=["apple", "orange"], coerce=True)
    price: Series[float] = pa.Field(gt=0, coerce=True, nullable=True)


schema = pa.DataFrameSchema({
    "item": pa.Column(str, pa.Check.isin(["apple", "orange"]), coerce=True),
    "price": pa.Column(float, pa.Check.gt(0), coerce=True, nullable=True),
})

class OtherSchema(pa.DataFrameModel):
    transaction_id: Series[str]
    value: Series[float]


python_data = pd.DataFrame.from_records([
    {"item": "apple", "price": 0.5},
    {"item": "orange", "price": 0.75},
    {"item": "orange", "price": np.nan},
])
