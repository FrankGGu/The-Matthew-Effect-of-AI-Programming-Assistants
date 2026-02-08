class Solution:
    def minimumSum(self, s: str) -> int:
        i = 0
        j = len(s) - 1
        sum_val = 0
        while i < j:
            sum_val += ord(s[i]) - ord('0')
            sum_val += ord(s[j]) - ord('0')
            i += 1
            j -= 1
        return sum_val