# 得到所有的 .c 文件
ScrFiles = $(wildcard scr/*.cpp)

# 其中 % 通配符，用于模式匹配，就是对应格式，一一匹配所有符合项，
# 下面语句的作用是 ScrFiles 中每一带有 .cpp (%.cpp) 的都通过替换函数一一替换为 .o (%.o)文件
ObjFiles = $(patsubst %.cpp, %.o, $(ScrFiles))


main:$(ObjFiles)
	@g++ -o $@ $(ObjFiles)

# 模式匹配，具体就是：上面依赖 $(ObjFiles) 中第一项是
# 某一个 .o，因为找不到，根据递归推导，会向下查找， %.o 就对应了依赖中要找的那一项，
# %.cpp 就对应了当前路径下与前面 % 符所对应的源文件
# $@ 代指目标文件，也就是 %.o ， $< 代指第一个依赖文件，这里依赖文件也就一个 %.cpp，所以也就是 %.cpp
%.o:%.cpp
	@g++ -o $@ -c $<

.PHONY:clean

clean:
	@rm -f *.o
	@rm -f main

test:
	@echo $(ScrFiles)
	@echo $(ObjFiles)
