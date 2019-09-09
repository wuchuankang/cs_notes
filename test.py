"""
train.txt的构成是，每一行是一个文本+ 标签， 用tab分割
我们用训练集来建立词表(vocab)，这是因为在pytorch 中，如果不使用预先训练好的词向量，
那么nn.embedding 模块中会用一维标准正态分布来随机初始化词向量，在训练过程中，词向量也是学习参数；
如果使用训练集和验证集来构建词表，出自验证集中的词对应的词向量就没法更新，因为验证集不参与学习；
即使有预先使用的词向量，有时候，我们也将词向量作为学习参数；
"""
import jieba
为什么词表元素个数要取一给定的值，为什么不取训练集中所有的词？

#全局变量要大写
MAX_VOCAB_SIZE = 10000
UNK, PAD = '<unk>', '<pad>'   # 前者是oov(out of vocab)，词表之外的，比如出现在验证集和测试集中，还要去除掉的词频< min_freq 的词；后者是因为我们要将每一个样本搞成长度一致的数据，这样才好放到神经网络中去训练，我们会指定数据长度，超过了就截取，不足就用<pad>填充，值得注意的是，对于RNN一类的循环神经网络，可以只满足每一批数据长度相同，不同批的数据可以不同，这是因为每一批数据长度的不同，不会影响到各层权重的维度，只是最后序列输出个数不同（此处说的是y1,...,yT），但是一般最好处理成为个批序列都相同。

def tokenizer(text):
    return [_ for _ in jieba.cut(text)]


def build_vocab(path, tokenizer, max_vocab_size, min_freq):
    vocab = {}
    with open(path, 'r', encoding='utf-8') as f:

        for line in f.readlines():
            line = line.strip()  # 除去空格
            if not line:   #除去空格后，如果不是空行，那么就将该行分割为文本和标签
                line = line.split('\t')[0]   # 一定先尝试好，每行文本和标签是靠什么分割的，这里是用tab键分割的
                line = tokenizer(line)

                for word in line:   # 收集每个词的词频，用于将词频< min_freq的词给去掉
                    vocab[word] = vocab.get(word, 0) + 1

        word_list = sorted([_ for _ in vocab.items() if _[1]>min_freq], key=lambda x: x[1], reverse=True)   #去掉小于min_freq的词，并将词按照词频从高到低排列，用于后面词汇量> max_vocab_size 时，进行截取
        if len(word_list) > max_vocab_size:     # 词汇表进行截取
            word_list = word_list[:max_vocab_size]
        for id, item in enumerate(word_list):  #建立词汇表,  该命令等价于 vocab = {item=[0]:id for id, item in enumerate(vocab.items())} 
            vocab[item[0]] = id 
        vocab.update({UNK:len(vocab), PAD:len(vocab)+1})  #添加这两个特殊标记的索引

    return vocab








