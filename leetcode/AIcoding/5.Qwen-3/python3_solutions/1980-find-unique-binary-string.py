class Solution:
    def findUniqueBinaryString(self, nums: List[str]) -> str:
        s = set(nums)
        n = len(nums)
        for i in range(1 << n):
            binary = bin(i)[2:].zfill(n)
            if binary not in s:
                return binary
        return ""