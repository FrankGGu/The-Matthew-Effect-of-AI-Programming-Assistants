class Solution:
    def longestString(self, a: int, b: int, c: int, d: int) -> int:
        from collections import deque

        count = [a, b, c, d]
        chars = ['a', 'b', 'c', 'd']
        last = ''
        res = 0
        q = deque()

        while True:
            found = False
            for i in range(4):
                if count[i] > 0 and chars[i] != last:
                    q.append((chars[i], i))
                    count[i] -= 1
                    last = chars[i]
                    res += 1
                    found = True
                    break
            if not found:
                break
            while q:
                ch, idx = q.popleft()
                count[idx] += 1
                if count[idx] > 0 and ch != last:
                    q.append((ch, idx))
                    count[idx] -= 1
                    last = ch
                    res += 1
                    found = True
                    break
            if not found:
                break
        return res