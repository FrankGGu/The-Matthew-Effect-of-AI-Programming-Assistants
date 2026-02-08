class Solution:
    def loudAndRich(self, richer, quiet, n):
        from collections import defaultdict, deque

        graph = defaultdict(list)
        in_degree = [0] * n

        for u, v in richer:
            graph[v].append(u)
            in_degree[u] += 1

        result = [0] * n
        queue = deque()

        for i in range(n):
            result[i] = i

        for i in range(n):
            if in_degree[i] == 0:
                queue.append(i)

        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                if quiet[result[neighbor]] > quiet[result[node]]:
                    result[neighbor] = result[node]
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        return result