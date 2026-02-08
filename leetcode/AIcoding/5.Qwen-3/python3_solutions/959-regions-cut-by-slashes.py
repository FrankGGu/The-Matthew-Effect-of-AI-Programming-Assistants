class Solution:
    def regionsBySlashes(self, grid):
        n = len(grid)
        parent = list(range(4 * n * n))

        def find(x):
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(x, y):
            parent[find(x)] = find(y)

        for i in range(n):
            for j in range(n):
                base = 4 * (i * n + j)
                if grid[i][j] == '/':
                    union(base, base + 1)
                    union(base + 2, base + 3)
                elif grid[i][j] == '\\':
                    union(base, base + 2)
                    union(base + 1, base + 3)
                else:
                    union(base, base + 1)
                    union(base, base + 2)
                    union(base, base + 3)
                if i > 0:
                    up = 4 * ((i - 1) * n + j)
                    union(base, up + 3)
                if j > 0:
                    left = 4 * (i * n + (j - 1))
                    union(base + 1, left + 2)
        roots = set()
        for i in range(4 * n * n):
            roots.add(find(i))
        return len(roots)