---
date: '2026-06-29T08:00:00+07:00'
draft: false
title: 'Python itertools: Elegant Iteration Patterns for Data Science'
tags: ['python', 'data-science', 'itertools', 'standard-library', 'tutorial']
categories: ['insight-data-and-research']
description: 'Explore Python itertools — a powerful standard library module that brings lazy evaluation, combinatorial generators, and efficient looping patterns to your data science toolkit.'
---

## Introduction

Last time, we explored the `collections` module and how its specialized containers can simplify everyday data tasks. Today, I want to dive into another standard library gem that every data scientist should have in their back pocket: **`itertools`**.

The `itertools` module provides a collection of fast, memory-efficient tools for working with iterators. Many of these ideas come from functional programming languages like Haskell and APL, but Python makes them feel natural and readable.

What I love about `itertools` is that it encourages you to think in terms of **streams of data** rather than materialized lists. For data science, where datasets can be massive, this lazy evaluation mindset is not just elegant — it is practical.

Let us explore the most useful functions and see how they apply to real data workflows.

---

## 1. Infinite Iterators: count, cycle, repeat

Sometimes you need a sequence that never ends — or at least, never ends until you tell it to.

```python
from itertools import count, cycle, repeat

# count(start, step) — infinite arithmetic sequence
for i in count(10, 2):
    if i > 20: break
    print(i)  # 10, 12, 14, 16, 18, 20

# cycle — repeat a sequence forever
colors = cycle(['red', 'green', 'blue'])
print([next(colors) for _ in range(5)])
# ['red', 'green', 'blue', 'red', 'green']

# repeat — yield the same value N times (or forever)
print(list(repeat('hello', 3)))  # ['hello', 'hello', 'hello']
```

**Data Science Use Case:** Generating synthetic data streams, cycling through color palettes for multi-line plots, or creating index sequences for sliding windows.

---

## 2. Accumulate — Running Totals and Beyond

`accumulate` is like `cumsum` on steroids. By default it computes running sums, but you can pass any binary function.

```python
from itertools import accumulate
import operator

data = [1, 2, 3, 4, 5]

# Running sum (like numpy.cumsum)
print(list(accumulate(data)))
# [1, 3, 6, 10, 15]

# Running product
print(list(accumulate(data, operator.mul)))
# [1, 2, 6, 24, 120]

# Running max
temperatures = [22, 25, 21, 27, 26, 30, 28]
print(list(accumulate(temperatures, max)))
# [22, 25, 25, 27, 27, 30, 30]
```

**Data Science Use Case:** Computing cumulative returns in financial analysis, tracking running maximums in time series, or building prefix sums for efficient range queries.

---

## 3. Chain and Chain.from_iterable — Flattening Without Loops

When you have multiple iterables and want to process them as one continuous stream, `chain` is your friend.

```python
from itertools import chain

# Chain multiple iterables
list1 = [1, 2, 3]
list2 = [4, 5, 6]
list3 = [7, 8, 9]

print(list(chain(list1, list2, list3)))
# [1, 2, 3, 4, 5, 6, 7, 8, 9]

# Chain.from_iterable — flatten one level
batches = [[1, 2], [3, 4], [5, 6]]
print(list(chain.from_iterable(batches)))
# [1, 2, 3, 4, 5, 6]
```

**Data Science Use Case:** Merging data from multiple files or API responses into a single iterable without loading everything into memory at once. Very useful when processing batched data from a generator.

---

## 4. Combinatoric Generators: product, permutations, combinations

These are the workhorses for any task involving combinations or arrangements.

```python
from itertools import product, permutations, combinations, combinations_with_replacement

# product — Cartesian product (like nested for-loops)
colors = ['red', 'blue']
sizes = ['S', 'M', 'L']
print(list(product(colors, sizes)))
# [('red', 'S'), ('red', 'M'), ('red', 'L'),
#  ('blue', 'S'), ('blue', 'M'), ('blue', 'L')]

# permutations — all possible orderings
print(list(permutations('ABC', 2)))
# [('A', 'B'), ('A', 'C'), ('B', 'A'), ('B', 'C'), ('C', 'A'), ('C', 'B')]

# combinations — all subsets of size r (order doesn't matter)
print(list(combinations('ABCD', 2)))
# [('A', 'B'), ('A', 'C'), ('A', 'D'), ('B', 'C'), ('B', 'D'), ('C', 'D')]

# combinations_with_replacement — allow repeated elements
print(list(combinations_with_replacement('AB', 2)))
# [('A', 'A'), ('A', 'B'), ('B', 'B')]
```

**Data Science Use Case:** Hyperparameter grid search (product), feature selection (combinations), A/B test group assignments (permutations), or generating candidate sets for market basket analysis.

---

## 5. islice and tee — Slicing and Splitting Iterators

Regular slicing (`data[10:20]`) does not work on generators. `islice` fills that gap.

```python
from itertools import islice, tee

# islice — slice an iterator without materializing it
def read_large_file():
    """Simulate reading a large file line by line."""
    for i in range(1000000):
        yield f"line {i}"

# Get lines 100-109 without loading the whole file
lines = islice(read_large_file(), 100, 110)
print(list(lines))
# ['line 100', 'line 101', ..., 'line 109']

# tee — split one iterator into N independent iterators
data = iter(range(10))
it1, it2 = tee(data, 2)

print(sum(it1))  # 45
print(list(it2))  # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

**Data Science Use Case:** `islice` is perfect for peeking at the first N rows of a large dataset or skipping headers. `tee` lets you feed the same data stream into multiple downstream computations without re-reading from disk.

---

## 6. groupby — Consecutive Grouping

`groupby` groups **consecutive** elements that share a key. Important: the input must be sorted by the key first.

```python
from itertools import groupby

# Must sort by the same key function first!
data = [('A', 1), ('A', 2), ('B', 3), ('B', 4), ('A', 5)]
data.sort(key=lambda x: x[0])

for key, group in groupby(data, key=lambda x: x[0]):
    print(f"{key}: {list(group)}")
# A: [('A', 1), ('A', 2)]
# B: [('B', 3), ('B', 4)]
# A: [('A', 5)]
```

Notice how the second `A` group is separate? That is because `groupby` only merges **adjacent** elements. If you want all `A` together, sort first.

**Data Science Use Case:** Segmenting time-series data by state, grouping log entries by session, or computing run-length encoding for compression.

---

## 7. Practical Example: Sliding Window with zip

One of the most common patterns in time-series analysis is the sliding window. You can build one elegantly with `tee` and `islice`:

```python
from itertools import tee, islice

def sliding_window(iterable, n=3):
    """Generate overlapping subsequences of size n."""
    iters = tee(iterable, n)
    for i, it in enumerate(iters):
        # Advance each iterator by i positions
        for _ in range(i):
            next(it, None)
    return zip(*iters)

# Usage
data = [10, 20, 30, 40, 50, 60]
for window in sliding_window(data, n=3):
    print(window)
# (10, 20, 30)
# (20, 30, 40)
# (30, 40, 50)
# (40, 50, 60)

# Compute moving averages
data = [10, 20, 30, 40, 50]
moving_avg = [sum(w) / len(w) for w in sliding_window(data, n=3)]
print(moving_avg)  # [20.0, 30.0, 40.0]
```

**Data Science Use Case:** Moving averages, rolling statistics, n-gram generation for text, or any feature engineering that requires looking at neighboring data points.

---

## Performance Comparison: itertools vs. Lists

Let us see why lazy evaluation matters. Here is a quick benchmark comparing a list-based approach to an itertools approach:

```python
import sys
from itertools import chain

# List approach: materializes everything
big_list = list(range(1_000_000))
print(f"List size: {sys.getsizeof(big_list) / 1024 / 1024:.1f} MB")
# List size: ~7.6 MB

# Itertools approach: lazy, constant memory
lazy_chain = chain(range(500_000), range(500_000))
print(f"Iterator size: {sys.getsizeof(lazy_chain)} bytes")
# Iterator size: ~64 bytes
```

The memory difference is dramatic. For a one-pass computation, there is no need to hold everything in RAM.

---

## Quick Reference Table

| Function | Purpose | Data Science Application |
|----------|---------|--------------------------|
| `count()` | Infinite arithmetic sequence | Index generation, synthetic data |
| `cycle()` | Infinite repetition of a sequence | Color cycling, round-robin sampling |
| `repeat()` | Repeat a value N times | Padding, constant arrays |
| `accumulate()` | Running totals / reductions | Cumulative returns, running max |
| `chain()` | Concatenate iterables | Merging data streams |
| `product()` | Cartesian product | Hyperparameter grids |
| `permutations()` | All orderings | Feature arrangement tests |
| `combinations()` | All subsets of size r | Feature selection |
| `islice()` | Slice an iterator | Peeking at large files |
| `tee()` | Split iterator into N copies | Multi-pass over generators |
| `groupby()` | Group consecutive elements | State segmentation, RLE |

---

## Wrapping Up

The `itertools` module is one of those tools that quietly makes your code faster, cleaner, and more memory-efficient. It rewards you for thinking in terms of data streams rather than materialized collections — a mindset that pays off enormously as your datasets grow.

My advice: next time you reach for a nested loop or a list comprehension that builds an intermediate list, pause and check if `itertools` has a function that does the same thing lazily. You will be surprised how often it does.

Happy iterating!

~ Kang Ifaz
