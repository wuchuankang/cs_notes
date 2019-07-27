from collections import defaultdict
string = 'hisishaglole'
word_dict = defaultdict(int)

def find_first_word(string):
    for i in string:
        word_dict[i] += 1
    for i in string:
        if word_dict[i] == 1:
            return i


word = find_first_word(string)
print(word)
