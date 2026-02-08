from collections import defaultdict, deque

class Solution:
    def findLadders(self, beginWord: str, endWord: str, wordList: List[str]) -> List[List[str]]:
        wordSet = set(wordList)
        if endWord not in wordSet:
            return []

        neighbors = defaultdict(list)
        wordSet.add(beginWord)

        for word in wordSet:
            for i in range(len(word)):
                pattern = word[:i] + '*' + word[i+1:]
                neighbors[pattern].append(word)

        result = []
        level = {beginWord}
        parent = defaultdict(set)

        found = False
        while level and not found:
            next_level = defaultdict(set)
            for word in level:
                for i in range(len(word)):
                    pattern = word[:i] + '*' + word[i+1:]
                    for neighbor in neighbors[pattern]:
                        if neighbor not in parent[word]:
                            parent[neighbor].add(word)
                            next_level[neighbor].add(neighbor)
                            if neighbor == endWord:
                                found = True
            level = next_level

        def backtrack(node, path):
            if node == beginWord:
                path.append(node)
                result.append(path[::-1])
                path.pop()
                return
            for prev in parent[node]:
                path.append(node)
                backtrack(prev, path)
                path.pop()

        if endWord in parent:
            backtrack(endWord, [])

        return result