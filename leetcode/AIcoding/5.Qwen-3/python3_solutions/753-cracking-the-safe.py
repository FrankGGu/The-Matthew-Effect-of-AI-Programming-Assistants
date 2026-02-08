class Solution:
    def crackSafe(self, n: int, k: int) -> str:
        visited = set()
        result = []

        def dfs(node):
            for i in range(k):
                next_node = node + str(i)
                if next_node not in visited:
                    visited.add(next_node)
                    dfs(next_node[1:])
                    result.append(str(i))

        if n == 1:
            return ''.join(str(i) for i in range(k))
        dfs('0' * (n - 1))
        return '0' * (n - 1) + ''.join(result)