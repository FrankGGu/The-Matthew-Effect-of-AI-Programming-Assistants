class Solution:
    def minimizeArrayValue(self, arr: List[int]) -> int:
        res = 0
        total = 0
        for i in range(len(arr)):
            total += arr[i]
            res = max(res, (total + i) // (i + 1))
        return res