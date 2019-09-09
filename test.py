import jieba

#全局变量要大写
MAX_VOCAB_SIZE = 10000
UNK, PAD = '<unk>', '<pad>'



def tokenizer(text):
    return [_ for _ in jieba.cut(text)]


def build_vocab(path, tokenizer, max_vocab_size, min_freq):
    vocab = {}
    with open(path, 'r', encoding='utf-8') as f:

        for line in f.readlines():
            line = line.strip()  # 除去空格
            if not line:   #除去空格后如果
                line = line.split('\t')[0]
                line = tokenizer(line)

                for word in line:
                    vocab[word] = vocab.get(word, 0) + 1

        word_list = sorted([_ for _ in vocab.items() if _[1]>min_freq], key=lambda x: x[1], reverse=True)
        if len(word_list) > max_vocab_size:
            word_list = word_list[:max_vocab_size]
        for id, item in enumerate(word_list):






