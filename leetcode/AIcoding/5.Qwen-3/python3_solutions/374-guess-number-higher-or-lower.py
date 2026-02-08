class Solution:
    def guessNumber(self, n: int) -> int:
        left, right = 1, n
        while left <= right:
            mid = left + (right - left) // 2
            result = guess(mid)
            if result == 0:
                return mid
            elif result == 1:
                left = mid + 1
            else:
                right = mid - 1
        return left