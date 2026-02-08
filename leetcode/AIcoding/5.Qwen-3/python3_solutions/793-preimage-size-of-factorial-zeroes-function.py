class Solution:
    def preimage(self, x: int) -> int:
        def trailing_zeros(n):
            count = 0
            while n > 0:
                n //= 5
                count += n
            return count

        def find_left(x):
            left, right = 0, 5 * x
            while left < right:
                mid = (left + right) // 2
                if trailing_zeros(mid) < x:
                    left = mid + 1
                else:
                    right = mid
            return left

        left = find_left(x)
        return left + 1 - find_left(x + 1)