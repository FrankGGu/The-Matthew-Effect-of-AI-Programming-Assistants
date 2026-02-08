class Solution:
    def maxSubarrayMinProduct(self, nums):
        MOD = 10**9 + 7
        n = len(nums)
        left = [ -1 ] * n
        right = [ n ] * n
        stack = []
        for i in range(n):
            while stack and nums[stack[-1]] >= nums[i]:
                stack.pop()
            if stack:
                left[i] = stack[-1]
            else:
                left[i] = -1
            stack.append(i)
        stack = []
        for i in range(n-1, -1, -1):
            while stack and nums[stack[-1]] > nums[i]:
                stack.pop()
            if stack:
                right[i] = stack[-1]
            else:
                right[i] = n
            stack.append(i)
        res = 0
        for i in range(n):
            count = right[i] - left[i] - 1
            total = nums[i] * count
            res = max(res, total)
        return res % MOD