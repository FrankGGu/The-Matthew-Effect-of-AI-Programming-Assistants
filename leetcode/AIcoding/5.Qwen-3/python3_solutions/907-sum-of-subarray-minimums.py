class Solution:
    def sumSubarrayMins(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        left = [0] * n
        right = [0] * n

        stack = []
        for i in range(n):
            count = 1
            while stack and nums[stack[-1]] > nums[i]:
                count += left[stack.pop()]
            left[i] = count
            stack.append(i)

        stack = []
        for i in range(n - 1, -1, -1):
            count = 1
            while stack and nums[stack[-1]] >= nums[i]:
                count += right[stack.pop()]
            right[i] = count
            stack.append(i)

        result = 0
        for i in range(n):
            result = (result + nums[i] * left[i] * right[i]) % MOD

        return result