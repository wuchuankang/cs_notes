## <center> 关于mergesort中递归的理解和分析
      人类理解循环，上帝理解递归  

* 函数递归的实现：  
    在计算机中，是以栈的方式进行存储，那么将会以入栈和出栈的方式工作，所以在出现前，如果你有一些变量没有用，那么就是无效的变量，但你认为自己用了，那么就会出错，这是对递归运行方式（出栈、入栈）理解不清楚造成的。
* 下面以mergesort进行案例分析:   
    自己写的一开始写的由错误，发现了，竟然不知道如何更改  
    下面这个是完整正确的
    ```python
    a = [5,4,8,7,6,2,3]

    def merge(left, right):
        """merge

        :param left: left part
        :param right: right part
        """
        i = 0
        j = 0
        sorted_list = []
        for k in range(len(left)+len(right)):
            if left[i] < right[j]:
                sorted_list.append(left[i])
                i += 1
                if i == len(left):
                    left.append(float('inf'))
            else:
                sorted_list.append(right[j])
                j += 1
                if j == len(right):
                    right.append(float('inf'))
        return sorted_list

    def mergesort(a):
        """mergesort

        :param a: 这是要进行排序的列表
        """
        #basecase
        if len(a) < 2:
            return a
        else:
            left  = a[: len(a)//2]
            right = a[len(a)//2 :]

            left_new = mergesort(left)
            right_new = mergesort(right)
            return merge(left_new, right_new)

    b = mergesort(a)
    ```
    下面是我一开始写错的地方，错误在mergesort：  
    ```python
    def mergesort(a):
        """mergesort

        :param a: 这是要进行排序的列表
        """
        
        left  = a[: len(a)//2]
        right = a[len(a)//2 :]

        #basecase
        if len(left) < 2:
            return left
        if len(right) < 2:
            return right
        left_new = mergesort(left)
        right_new = mergesort(right)
        return merge(left_new, right_new)
    ```
    错误之处：  
    当$len(left)<2$，那么return语句就会使程序出栈，那么当前的right就没有用了，出栈后，进入上层栈，那么right也就是上层栈的right，那么你就丢低了一部分数据，结果自然不对了。


