class Solution:
    def findRedundantConnection(self, edges: List[List[int]]) -> List[int]:
        parent = [0] * (len(edges) + 1)

        def find(x):
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX == rootY:
                return False
            parent[rootY] = rootX
            return True

        for u, v in edges:
            if parent[u] == 0:
                parent[u] = u
            if parent[v] == 0:
                parent[v] = v
            if not union(u, v):
                return [u, v]

        return []