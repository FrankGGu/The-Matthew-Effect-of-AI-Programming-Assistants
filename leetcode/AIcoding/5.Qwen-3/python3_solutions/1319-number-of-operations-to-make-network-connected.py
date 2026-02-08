class Solution:
    def makeConnected(self, n: int, connections: List[int]) -> int:
        if len(connections) < n - 1:
            return -1

        parent = list(range(n))

        def find(x):
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX == rootY:
                return
            parent[rootY] = rootX

        for x, y in connections:
            union(x, y)

        roots = set()
        for i in range(n):
            roots.add(find(i))

        return len(roots) - 1