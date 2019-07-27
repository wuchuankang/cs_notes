

G = [2, 3, 4, 5]


def WIS(G):
    Sub_G = []
    Weight = []
    if len(G)==0:
        return None, None
    if len(G)==1:
        Weight.append(G[0]) 
        Sub_G.append(G[0])
        return Weight, Sub_G
    else:
        Weight += [0,G[0]]
        for i in range(2, len(G)+1):
            max_w = max(Weight[i-2]+G[i-1], Weight[i-1])
            Weight.append(max_w)
        index = len(Weight)-1
        while index > 2 or index==2:
            if Weight[index-2] + G[index-1] > Weight[index-1]:
                Sub_G.append(G[index-1])
                index -= 2
            else:
                index -= 1

        if index == 1:
            Sub_G.append(G[0])


        Sub_G = list(reversed(Sub_G))
        return Weight, Sub_G

                

           
Weight, Sub_G = WIS(G)            
print(Sub_G)
print(Weight)

G = [2,3,4]
Weight, Sub_G = WIS(G)            
print(Sub_G)
print(Weight)
