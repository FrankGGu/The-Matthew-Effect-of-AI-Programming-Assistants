class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        from collections import deque
        q = deque()
        for num in nums:
            q.append(num)
        operations = 0
        while len(q) > 1:
            a = q.popleft()
            b = q.popleft()
            if a < k and b < k:
                q.append(a + b)
                operations += 1
            else:
                q.append(a)
                q.append(b)
        return operations