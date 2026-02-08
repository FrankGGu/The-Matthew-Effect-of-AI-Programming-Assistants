class Solution:
    def digitCount(self, num: str) -> bool:
        count = [0] * 10
        for ch in num:
            digit = int(ch)
            count[digit] += 1
        for i in range(10):
            if count[i] != int(num[i]):
                return False
        return True