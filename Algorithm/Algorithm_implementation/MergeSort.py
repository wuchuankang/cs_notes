
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
print(b)
