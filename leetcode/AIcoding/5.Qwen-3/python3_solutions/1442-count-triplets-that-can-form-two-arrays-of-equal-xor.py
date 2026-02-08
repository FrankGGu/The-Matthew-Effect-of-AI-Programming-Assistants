class Solution:
    def countTriplets(self, arr: List[int]) -> int:
        n = len(arr)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] ^ arr[i]
        res = 0
        for i in range(n):
            for j in range(i + 1, n):
                if prefix[i] == prefix[j]:
                    res += n - j
        return res