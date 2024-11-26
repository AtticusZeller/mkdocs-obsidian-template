# Code

## Block

```python
from typing import Union

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
async def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}
```

## Inline

The `range()` function is used to generate a sequence of numbers.

[[docs/Features/Diagrams|Diagrams]]
[Diagrams](Diagrams.md)
[Draw](docs/Features/Draw.md)

```python,shell
from fastapi impart FastAPI
```

- item 1
  - item 2
  - item 3

1. Item 1
2. Item 2
3. Item 3
Some text here
4. Item 1
5. Item 2
6. Item 3

Lorem ( … ) __Impsum__.

- item 1
- copypasted _item_ A
- item 2
- indented item
- copypasted item B

 as
