from collections import deque
from typing import Optional, List

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def minimumOperations(self, root: Optional[TreeNode]) -> int:
        def count_swaps(arr):
            sorted_arr = sorted(arr)
            pos = {val: i for i, val in enumerate(sorted_arr)}
            visited = [False] * len(arr)
            swaps = 0
            for i in range(len(arr)):
                if visited[i]:
                    continue
                cycle_size = 0
                j = i
                while not visited[j]:
                    visited[j] = True
                    j = pos[arr[j]]
                    cycle_size += 1
                if cycle_size > 0:
                    swaps += (cycle_size - 1)
            return swaps

        q = deque()
        q.append(root)
        operations = 0
        while q:
            level_size = len(q)
            level_nodes = []
            for _ in range(level_size):
                node = q.popleft()
                level_nodes.append(node.val)
                if node.left:
                    q.append(node.left)
                if node.right:
                    q.append(node.right)
            operations += count_swaps(level_nodes)
        return operations