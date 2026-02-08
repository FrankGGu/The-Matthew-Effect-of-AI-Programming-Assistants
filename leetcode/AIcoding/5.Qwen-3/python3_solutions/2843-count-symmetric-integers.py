class Solution:
    def countSymmetricIntegers(self, s: str) -> int:
        count = 0
        for i in range(1, len(s), 2):
            left = s[i-1]
            right = s[i]
            if left == right:
                count += 1
        return count