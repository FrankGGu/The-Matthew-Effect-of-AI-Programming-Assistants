class Solution:
    def countUnreachablePairs(self, df: int, edges: List[List[int]]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * df
        result = 0
        total_nodes = df

        def bfs(start):
            queue = deque([start])
            visited[start] = True
            count = 0
            while queue:
                node = queue.popleft()
                count += 1
                for neighbor in graph[node]:
                    if not visited[neighbor]:
                        visited[neighbor] = True
                        queue.append(neighbor)
            return count

        for i in range(df):
            if not visited[i]:
                size = bfs(i)
                result += size * (total_nodes - size)
                total_nodes -= size

        return result