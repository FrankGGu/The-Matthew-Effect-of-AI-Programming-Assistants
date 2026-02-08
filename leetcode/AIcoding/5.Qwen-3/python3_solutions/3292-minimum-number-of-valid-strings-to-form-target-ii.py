class Solution:
    def minValidStrings(self, words, target: str) -> int:
        from collections import defaultdict

        trie = {}

        for word in words:
            node = trie
            for c in word:
                if c not in node:
                    node[c] = {}
                node = node[c]

        res = 0
        i = 0
        while i < len(target):
            node = trie
            max_len = 0
            for j in range(i, len(target)):
                if target[j] not in node:
                    break
                node = node[target[j]]
                max_len += 1
            if max_len == 0:
                return -1
            i += max_len
            res += 1

        return res