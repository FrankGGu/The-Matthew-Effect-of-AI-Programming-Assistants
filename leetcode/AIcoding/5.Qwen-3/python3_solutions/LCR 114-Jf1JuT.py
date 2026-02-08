class Solution:
    def alienOrder(self, words: List[str], order: str) -> str:
        from collections import defaultdict, deque

        adj = defaultdict(set)
        visited = {}
        result = []

        for word in words:
            for ch in word:
                if ch not in visited:
                    visited[ch] = 0

        for i in range(len(words) - 1):
            word1 = words[i]
            word2 = words[i + 1]
            min_len = min(len(word1), len(word2))
            if len(word1) > len(word2) and word1[:min_len] == word2[:min_len]:
                return ""
            for j in range(min_len):
                ch1 = word1[j]
                ch2 = word2[j]
                if ch1 != ch2:
                    if ch2 not in adj[ch1]:
                        adj[ch1].add(ch2)
                    break

        for ch in visited:
            if visited[ch] == 0:
                if not self.dfs(ch, adj, visited, result):
                    return ""

        return ''.join(result)

    def dfs(self, ch, adj, visited, result):
        if visited[ch] == 1:
            return False
        if visited[ch] == 2:
            return True
        visited[ch] = 1
        for neighbor in adj[ch]:
            if not self.dfs(neighbor, adj, visited, result):
                return False
        visited[ch] = 2
        result.append(ch)
        return True