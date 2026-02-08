class Solution:
    def maxScore(self, nums: List[int]) -> int:
        from collections import deque

        nums = deque(nums)
        score = 0
        turn = 0

        while nums:
            if turn % 2 == 0:
                score += nums.popleft()
            else:
                score += nums.pop()
            turn += 1

        return score