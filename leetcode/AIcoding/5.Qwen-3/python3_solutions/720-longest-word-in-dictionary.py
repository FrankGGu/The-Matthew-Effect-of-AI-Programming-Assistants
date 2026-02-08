class Solution:
    def longestWord(self, words):
        words.sort()
        word_set = set(words)
        result = ""
        for word in words:
            if len(word) > len(result) and all(word[:i] in word_set for i in range(1, len(word))):
                result = word
        return result