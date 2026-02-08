class Solution:
    def maxValue(self, n: int, index: int, maxSum: int) -> int:
        def check(k):
            left = max(k - index, 0)
            right = max(k - (n - 1 - index), 0)
            return (k + left) * (index + 1 - left) // 2 + (k + right) * (n - index - right) // 2 - k

        left, right = 1, maxSum
        while left < right:
            mid = (left + right + 1) // 2
            if check(mid) <= maxSum:
                left = mid
            else:
                right = mid - 1
        return left