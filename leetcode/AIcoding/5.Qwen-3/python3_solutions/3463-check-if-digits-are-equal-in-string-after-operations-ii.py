class Solution:
    def areDigitsEqual(self, s: str) -> bool:
        count = [0] * 10
        for c in s:
            count[int(c)] += 1
        first = -1
        for i in range(10):
            if count[i] > 0:
                first = count[i]
                break
        for i in range(10):
            if count[i] > 0 and count[i] != first:
                return False
        return True