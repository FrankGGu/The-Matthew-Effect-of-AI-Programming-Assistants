class Solution:
    def frogPosition(self, n: int, edges: List[List[int]], t: int, target: int) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * (n + 1)
        q = deque()
        q.append((1, 0, -1))  # (node, time, parent)
        visited[1] = True

        while q:
            node, time, parent = q.popleft()
            if time == t:
                return node
            children = []
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    children.append(neighbor)
            if not children:
                return node
            for child in children:
                visited[child] = True
                q.append((child, time + 1, node))
        return 1