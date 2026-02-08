class Solution:
    def minInteger(self, num: str, k: int) -> str:
        from collections import deque

        num = list(num)
        n = len(num)

        for i in range(n):
            if k <= 0:
                break
            min_pos = i
            for j in range(i + 1, min(n, i + k + 1)):
                if num[j] < num[min_pos]:
                    min_pos = j
            for j in range(min_pos, i, -1):
                num[j], num[j - 1] = num[j - 1], num[j]
                k -= 1
            if k <= 0:
                break

        return ''.join(num)