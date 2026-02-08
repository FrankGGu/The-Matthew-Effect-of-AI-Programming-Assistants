class Solution:
    def nthUglyNumber(self, n: int) -> int:
        import heapq

        def count(num, a, b, c):
            return num // a + num // b + num // c - num // (a * b) - num // (a * c) - num // (b * c) + num // (a * b * c)

        left, right = 1, 2 * 10**9
        while left < right:
            mid = (left + right) // 2
            if count(mid, 2, 3, 5) < n:
                left = mid + 1
            else:
                right = mid
        return left