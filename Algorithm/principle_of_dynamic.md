# <center> principle of dynamic <center>
## the dynamic programming paradigm   
* identify a relatively small collection of subproble 
* show how to quickly and correctly solve 'larger' subprobles given the solutions to smaller ones   
* show how to quickly and correctly infer the final solution from the solutions to all of the subproblems 
### supplement:
对于上面的第二点，可以从两方面取考虑，一个是top-down ，一个是bottle-up。  
top-down 意思是：假定给定整个问题的解，那么我怎么求解比它小一个或者两个规模问题的解；  
bottle-up意思是：假定给定n-1个规模或者更小一点规模问题的解，怎么求得n个问题规模的解。

### notes:
systematically solve all the subprobles one by one , working from 'smallest ' to 'largest ', and extract the final solutions from those of the subproblems .

### notice:
动态规划有一个常见的误区，那就是以为要将子问题完全解决，再来解决original problem。  
我们从两个经典的问题入手：  
* 最大权重独立子集
* knapsack问题  

先来看看问题的结构，前者找到一个独立子集使得子集元素的权重的和为最大，后者是找到一堆物品的子集，在这个子集满足其元素大小和小于等于包的空间的前提下，子集价值最大。  
结构就是：  
目的都是找到子集，特性是这子集是最优量。  
solution：  
找解的结构，如何分析解的结构，**其实就是将整个集合看成是具有某种排列顺序**，这样就可以从两方面去分析，首先我们假定具有n个元素规模的问题为$Q_n$，最优解为$S_n$:
* 如果解不包含最后一个元素，那么$S_n$是否是$Q_{n-1}$的解
* 如果包含最后一个元素，那么$S_n-a_n$的集合是$Q_{n-1}$或者$Q_{n-2}$的最优解么  

这么一分析，就找到了原始问题和小规模问题的关系；  
但是这里注意到一个问题就是，我们从base case 开始，很容易计算出最优量，而不是最优的集合，但问题也很简单，在来一个top-down，回溯的记录使用了哪些量来计算出原始问题的最优量即可。具体的可以参照上面谈到这两个问题的伪代码和程序。  
还要说明的一点：basecase 要注意空集合的问题，这在具体问题具体分析
