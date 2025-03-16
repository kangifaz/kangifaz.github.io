---
date: '2025-03-16T15:25:02+07:00'
draft: false
title: 'Deep Learning'
weight: 3
---
### ✅ Deep Learning (TensorFlow & PyTorch)
- Basics of neural networks
- Training and evaluating deep learning models

**Example:**
```python
import tensorflow as tf

model = tf.keras.Sequential([
    tf.keras.layers.Dense(10, activation='relu', input_shape=(4,)),
    tf.keras.layers.Dense(1)
])

model.compile(optimizer='adam', loss='mse')
```