class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        from collections import deque
        q = deque(nums)
        operations = 0
        while sum(q) < k:
            q.append(q.popleft() + q.popleft())
            operations += 1
        return operations