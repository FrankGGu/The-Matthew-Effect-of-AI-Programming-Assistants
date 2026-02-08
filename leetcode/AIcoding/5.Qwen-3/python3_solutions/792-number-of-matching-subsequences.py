class Solution:
    def numMatchingSubseq(self, s: str, words: List[str]) -> int:
        from collections import defaultdict

        def is_subsequence(word, s):
            it = iter(s)
            return all(c in it for c in word)

        word_dict = defaultdict(list)
        for word in words:
            word_dict[word[0]].append(word)

        result = 0
        for char in word_dict:
            for word in word_dict[char]:
                if is_subsequence(word, s):
                    result += 1

        return result