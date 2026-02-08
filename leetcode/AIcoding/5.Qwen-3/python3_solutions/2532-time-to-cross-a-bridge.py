from typing import List

class Solution:
    def timeToCross(self, a: List[int]) -> int:
        a.sort()
        n = len(a)
        total_time = 0
        while n > 3:
            if a[0] + a[1] + 2 * a[-2] < a[0] + a[-1] + a[-2] + a[1]:
                total_time += a[0] + a[1] + a[-2]
            else:
                total_time += a[0] + a[-1] + a[-2] + a[1]
            a.pop()
            a.pop()
            n -= 2
        if n == 3:
            total_time += sum(a)
        elif n == 2:
            total_time += max(a)
        elif n == 1:
            total_time += a[0]
        return total_time