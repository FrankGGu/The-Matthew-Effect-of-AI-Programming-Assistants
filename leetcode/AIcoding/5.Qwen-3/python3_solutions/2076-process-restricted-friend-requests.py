class Solution:
    def friendRequests(self, numUsers: int, edges: List[List[int]]) -> int:
        parent = list(range(numUsers))

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

        for i in range(numUsers):
            for j in range(i + 1, numUsers):
                if find(i) == find(j):
                    continue
                union(i, j)

        count = [0] * numUsers
        for i in range(numUsers):
            count[find(i)] += 1

        result = 0
        for c in count:
            if c >= 2:
                result += c * (c - 1) // 2
        return result