class Solution:
    def findCriticalAndPseudoCriticalEdges(self, n, edges):
        def kruskal(n, edges, include=None, exclude=None):
            parent = list(range(n))

            def find(x):
                while parent[x] != x:
                    parent[x] = parent[parent[x]]
                    x = parent[x]
                return x

            def union(x, y):
                fx = find(x)
                fy = find(y)
                if fx == fy:
                    return False
                parent[fx] = fy
                return True

            total = 0
            count = 0
            for i, (u, v, w) in sorted(edges, key=lambda x: x[2]):
                if include is not None and i != include:
                    continue
                if exclude is not None and i == exclude:
                    continue
                if union(u, v):
                    total += w
                    count += 1
                    if count == n - 1:
                        break
            if count != n - 1:
                return float('inf')
            return total

        m = len(edges)
        min_spanning_tree_weight = kruskal(n, edges)

        critical = []
        pseudo_critical = []

        for i in range(m):
            weight = kruskal(n, edges, exclude=i)
            if weight > min_spanning_tree_weight:
                critical.append(i)
            else:
                weight_with = kruskal(n, edges, include=i)
                if weight_with == min_spanning_tree_weight:
                    pseudo_critical.append(i)

        return [critical, pseudo_critical]