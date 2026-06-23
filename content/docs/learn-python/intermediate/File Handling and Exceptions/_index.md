---
date: '2025-03-16T15:23:16+07:00'
draft: true
title: 'File Handling and Exceptions'
weight: 3
---
### ✅ File Handling and Exceptions
- Reading and writing files (`open()`, `read()`, `write()`)
- Exception handling (`try-except`)

**Example:**
```python
try:
    number = int(input("Enter a number: "))
    print(number)
except ValueError:
    print("Invalid input!")
```