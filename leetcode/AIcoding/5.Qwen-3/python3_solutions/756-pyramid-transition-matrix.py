class Solution:
    def pyramidTransitionMatrix(self, bottom: str, allowed: List[str]) -> bool:
        from collections import defaultdict

        graph = defaultdict(list)
        for s in allowed:
            graph[s[:2]].append(s[2])

        def dfs(current):
            if len(current) == 1:
                return True
            temp = []
            for i in range(len(current) - 1):
                temp.append(graph[current[i:i+2]])
            return any(dfs(''.join(x)) for x in itertools.product(*temp))

        return dfs(bottom)