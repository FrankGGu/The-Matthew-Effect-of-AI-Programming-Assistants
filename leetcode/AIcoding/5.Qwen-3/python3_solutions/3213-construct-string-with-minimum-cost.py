class Solution:
    def minCostToConstructString(self, n: int, brokenLetters: str) -> int:
        from collections import deque

        broken = set(brokenLetters)
        cost = 0
        queue = deque()

        for i in range(n):
            if i % 2 == 0:
                if 'a' not in broken:
                    cost += 1
                    queue.append('a')
                else:
                    cost += 1
                    queue.append('b')
            else:
                if 'b' not in broken:
                    cost += 1
                    queue.append('b')
                else:
                    cost += 1
                    queue.append('a')

        return cost