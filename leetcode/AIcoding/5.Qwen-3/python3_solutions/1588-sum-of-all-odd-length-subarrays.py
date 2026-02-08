class Solution:
    def sumOddLengthSubarrays(self, arr: List[int]) -> int:
        total = 0
        n = len(arr)
        for i in range(n):
            count = ((i + 1) * (n - i + 1) + 1) // 2
            total += arr[i] * count
        return total