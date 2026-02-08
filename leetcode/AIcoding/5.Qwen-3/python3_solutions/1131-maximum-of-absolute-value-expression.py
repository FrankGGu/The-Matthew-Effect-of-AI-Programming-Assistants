class Solution:
    def maxAbsValExpr(self, arr1: List[int], arr2: List[int]) -> int:
        max_val = 0
        n = len(arr1)
        for i in range(n):
            for j in range(i + 1, n):
                current = abs(arr1[i] - arr1[j]) + abs(arr2[i] - arr2[j])
                if current > max_val:
                    max_val = current
        return max_val