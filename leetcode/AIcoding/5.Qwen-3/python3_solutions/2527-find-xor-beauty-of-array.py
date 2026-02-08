class Solution:
    def xorBeauty(self, arr: List[int]) -> int:
        n = len(arr)
        res = 0
        for i in range(n):
            for j in range(i + 1, n):
                res ^= (arr[i] - arr[j])
        return res