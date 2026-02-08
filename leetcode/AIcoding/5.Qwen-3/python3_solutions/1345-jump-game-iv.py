from collections import deque
from typing import List

class Solution:
    def minJump(self, arr: List[int]) -> int:
        n = len(arr)
        index_map = {}
        for i, num in enumerate(arr):
            if num not in index_map:
                index_map[num] = []
            index_map[num].append(i)

        visited = [False] * n
        queue = deque()
        queue.append(0)
        visited[0] = True
        steps = 0

        while queue:
            for _ in range(len(queue)):
                current = queue.popleft()
                if current == n - 1:
                    return steps
                for neighbor in index_map[arr[current]]:
                    if not visited[neighbor]:
                        visited[neighbor] = True
                        queue.append(neighbor)
                index_map[arr[current]].clear()
                for delta in [-1, 1]:
                    next_index = current + delta
                    if 0 <= next_index < n and not visited[next_index]:
                        visited[next_index] = True
                        queue.append(next_index)
            steps += 1

        return -1