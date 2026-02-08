class Solution:
    def removeStones(self, stones: List[List[int]]) -> int:
        parent = {}

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            parent[find(x)] = find(y)

        for x, y in stones:
            if x not in parent:
                parent[x] = x
            if y not in parent:
                parent[y] = y
            union(x, y)

        roots = set()
        for x, y in stones:
            roots.add(find(x))

        return len(stones) - len(roots)