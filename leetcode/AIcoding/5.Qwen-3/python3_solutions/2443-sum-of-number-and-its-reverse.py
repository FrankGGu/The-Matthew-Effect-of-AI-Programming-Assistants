class Solution:
    def sumOfNumberAndReverse(self, num: int) -> int:
        return num + int(str(num)[::-1])