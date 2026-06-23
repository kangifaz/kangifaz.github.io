---
date: '2025-03-16T15:24:49+07:00'
draft: true
title: 'Machine Learning'
weight: 2
---
### ✅ Machine Learning (Scikit-Learn)
- Supervised Learning (Regression, Classification)
- Unsupervised Learning (Clustering)
- Model evaluation and validation

**Example:**
```python
from sklearn.linear_model import LinearRegression
import numpy as np

X = np.array([[1], [2], [3], [4]])
y = np.array([2, 4, 6, 8])

model = LinearRegression()
model.fit(X, y)
prediction = model.predict([[5]])
print(prediction)
```