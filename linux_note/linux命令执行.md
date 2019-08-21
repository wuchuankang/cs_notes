# 命令顺序执行和管道用法

## 多命令顺序执行
- ；是顺序执行，即使某个命令有误，也会执行下一个语句，比如：
```python
cd; ls; jdfid; cat  ~/.bashrc   # 第3 个语句有误，也会支持最后一个语句
```
- && 逻辑与，前一个命令执行，后一个命令才能执行，比如在github上编译源码安装时，可以才用：
```python
./configure && make && make install
```
- || 逻辑或，前一个命令正确，后一个不执行，反之后一个支持，比如判断一个命令是否正确，正确输出yes，否则输出no:
```python
命令 && echo 'yes' || echo 'no'
```

## 管道命令
将前一个命令输出作为后一个命令的输入， 用 | 连接  
```python
lspci | grep "Ethernet"
```- 
