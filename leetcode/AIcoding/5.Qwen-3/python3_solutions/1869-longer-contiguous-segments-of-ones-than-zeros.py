class Solution:
    def checkZeroOnes(self, s: str) -> bool:
        max_one = 0
        max_zero = 0
        count_one = 0
        count_zero = 0
        for c in s:
            if c == '1':
                count_one += 1
                count_zero = 0
                max_one = max(max_one, count_one)
            else:
                count_zero += 1
                count_one = 0
                max_zero = max(max_zero, count_zero)
        return max_one > max_zero