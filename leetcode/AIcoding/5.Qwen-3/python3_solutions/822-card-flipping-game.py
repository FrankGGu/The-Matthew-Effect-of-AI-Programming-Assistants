class Solution:
    def possibleBipartition(self, n: int, dislikes: List[List[int]]) -> bool:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in dislikes:
            graph[u].append(v)
            graph[v].append(u)

        color = [0] * (n + 1)

        for i in range(1, n + 1):
            if color[i] == 0:
                queue = deque()
                queue.append(i)
                color[i] = 1
                while queue:
                    node = queue.popleft()
                    for neighbor in graph[node]:
                        if color[neighbor] == 0:
                            color[neighbor] = -color[node]
                            queue.append(neighbor)
                        elif color[neighbor] == color[node]:
                            return False
        return True