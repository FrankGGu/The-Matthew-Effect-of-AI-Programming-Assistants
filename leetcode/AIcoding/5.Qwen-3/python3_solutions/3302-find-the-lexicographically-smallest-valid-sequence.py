class Solution:
    def findLexSmallestSequence(self, s: str) -> str:
        from collections import defaultdict

        def dfs(node, visited, path, adj):
            if node in visited:
                return False
            visited.add(node)
            for neighbor in sorted(adj[node], reverse=True):
                if dfs(neighbor, visited, path, adj):
                    return True
            path.append(node)
            return True

        adj = defaultdict(list)
        for i in range(len(s)):
            adj[s[i]].append(i)

        path = []
        visited = set()

        for char in sorted(adj.keys()):
            if char not in visited:
                dfs(char, visited, path, adj)

        result = [''] * len(s)
        for i in range(len(path)):
            result[path[i]] = s[i]

        return ''.join(result)