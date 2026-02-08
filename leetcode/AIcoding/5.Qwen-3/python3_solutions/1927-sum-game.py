class Solution:
    def sumGame(self, a: str, b: str) -> int:
        def count(s):
            x = 0
            for c in s:
                if c == '?':
                    x += 1
                else:
                    x += int(c)
            return x

        total_a = count(a)
        total_b = count(b)
        len_a = a.count('?')
        len_b = b.count('?')

        target = (total_a + total_b) // 2
        remaining = (len_a + len_b) // 2

        if (total_a + total_b) % 2 != 0:
            return 0

        diff = (total_a - total_b) // 2

        if diff > remaining:
            return 0
        elif diff < -remaining:
            return 0
        else:
            return 1