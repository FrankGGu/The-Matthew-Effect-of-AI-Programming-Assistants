class Solution:
    def minValidStrings(self, words, target):
        from collections import defaultdict

        trie = defaultdict(int)
        for word in words:
            node = trie
            for c in word:
                node = node[c]
                node['count'] = node.get('count', 0) + 1

        res = 0
        i = 0
        while i < len(target):
            node = trie
            max_len = 0
            for j in range(i, min(i + 20, len(target))):
                if target[j] not in node:
                    break
                node = node[target[j]]
                max_len += 1
            if max_len == 0:
                return -1
            i += max_len
            res += 1
        return res