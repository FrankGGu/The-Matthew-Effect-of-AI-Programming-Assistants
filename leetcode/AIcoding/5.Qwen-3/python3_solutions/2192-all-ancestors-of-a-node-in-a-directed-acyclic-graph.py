class Solution:
    def getAncestors(self, n: int, edges: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        in_degree = [0] * n

        for u, v in edges:
            graph[u].append(v)
            in_degree[v] += 1

        queue = deque()
        for i in range(n):
            if in_degree[i] == 0:
                queue.append(i)

        ancestors = [set() for _ in range(n)]

        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                ancestors[neighbor].add(node)
                ancestors[neighbor].update(ancestors[node])
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        return [sorted(list(s)) for s in ancestors]