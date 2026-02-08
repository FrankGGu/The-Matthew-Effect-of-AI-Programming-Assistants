class Solution:
    def isAdditiveNumber(self, num: str) -> bool:
        n = len(num)
        for i in range(1, n - 1):
            if num[0] == '0' and i > 1:
                break
            first = int(num[:i])
            for j in range(i + 1, n):
                if num[i] == '0' and j > i + 1:
                    break
                second = int(num[i:j])
                if self.check(num[j:], first, second):
                    return True
        return False

    def check(self, s: str, first: int, second: int) -> bool:
        while s:
            third = first + second
            third_str = str(third)
            if not s.startswith(third_str):
                return False
            s = s[len(third_str):]
            first, second = second, third
        return True