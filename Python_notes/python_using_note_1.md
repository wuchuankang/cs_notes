# python 学习笔记

## 1. 导入其他文件中的函数
假设由a.py和b.py两个文件，如果a.py要调用b.py中的某个函数func1，分两种情况来考虑：  
* 在同一个文件夹下
```python
from b import func1
import b
b.func1
```
* 在不同文件夹下
```python
import sys
sys.path.append('b.py的文件路径')
import b
b.func1
```

