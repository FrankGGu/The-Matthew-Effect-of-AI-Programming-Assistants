class Solution:
    def maxMatrixSum(self, matrix: List[List[int]]) -> int:
        min_abs = float('inf')
        total_sum = 0
        for row in matrix:
            for num in row:
                total_sum += num
                min_abs = min(min_abs, abs(num))
        if total_sum < 0:
            return total_sum + 2 * min_abs
        else:
            return total_sum