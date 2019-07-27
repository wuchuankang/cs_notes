import numpy as np

Value = [3, 2, 4, 4]
Size = [4, 3, 2, 3]
C = 6
n = len(Value)
A = np.zeros((n+1, C+1), int)

# base case
for c in range(C+1):
    A[0][c] = 0

for i in range(1, n+1):
    for c in range(C+1):
        if Size[i-1] > c:
            A[i][c] = A[i-1][c]
        else:
            A[i][c] = max(A[i-1][c], A[i-1][c-Size[i-1]] + Value[i-1])

print(A)

#reconstructure

Set = set()
c = C
for i in reversed(range(1, n+1)):
    if Size[i-1] < c and (A[i-1][c] < A[i][c-Size[i-1]]+Size[i-1] or  A[i-1][c] == A[i][c-Size[i-1]]+Size[i-1] ):
        Set.add(i)
        c = c-Size[i-1]

print(Set)


