class Solution:
    def sumOfEncryptedDigits(self, nums: List[int]) -> int:
        def encrypt(n):
            s = str(n)
            return int(s[0] * len(s))

        return sum(encrypt(n) for n in nums)