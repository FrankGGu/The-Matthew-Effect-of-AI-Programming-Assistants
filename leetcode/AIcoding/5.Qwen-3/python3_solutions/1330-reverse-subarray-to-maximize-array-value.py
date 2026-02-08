class Solution:
    def maxValueAfterReverse(self, A: List[int]) -> int:
        n = len(A)
        if n == 1:
            return 0
        total = 0
        for i in range(n - 1):
            total += abs(A[i] - A[i + 1])
        max_diff = 0
        for i in range(1, n - 1):
            diff = abs(A[i - 1] - A[i]) + abs(A[i] - A[i + 1])
            max_diff = max(max_diff, diff - abs(A[i - 1] - A[i + 1]))
        return total + max_diff