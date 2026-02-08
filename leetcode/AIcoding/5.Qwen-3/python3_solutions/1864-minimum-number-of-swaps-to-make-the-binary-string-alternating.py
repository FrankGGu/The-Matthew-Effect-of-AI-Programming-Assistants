class Solution:
    def minSwaps(self, s: str) -> int:
        even_0 = 0
        odd_0 = 0
        even_1 = 0
        odd_1 = 0

        for i in range(len(s)):
            if i % 2 == 0:
                if s[i] == '0':
                    even_0 += 1
                else:
                    even_1 += 1
            else:
                if s[i] == '0':
                    odd_0 += 1
                else:
                    odd_1 += 1

        if abs(even_0 - odd_0) > 1:
            return -1

        if len(s) % 2 == 0:
            return min(even_1, odd_1)
        else:
            if even_0 > odd_0:
                return odd_1
            else:
                return even_1