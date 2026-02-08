class Solution:
    def countVisitedNodes(self, head: 'Node') -> List[int]:
        from collections import defaultdict

        def dfs(node, visited, res, path):
            if node in visited:
                if node in path:
                    idx = path.index(node)
                    cycle = path[idx:]
                    for n in cycle:
                        res[n] = len(cycle)
                    for i in range(idx):
                        res[path[i]] = res[path[i+1]] + 1
                return
            visited.add(node)
            path.append(node)
            dfs(node.next, visited, res, path)
            path.pop()

        visited = set()
        res = defaultdict(int)
        path = []
        dfs(head, visited, res, path)
        return [res[node] for node in [head] * len(res)]