class Solution:
    def minMovesToMakePalindrome(self, s: str) -> int:
        from collections import deque

        s = list(s)
        n = len(s)
        q = deque()
        for i in range(n):
            q.append(s[i])
        res = 0
        while q:
            if len(q) == 1:
                return res
            if q[0] == q[-1]:
                q.popleft()
                q.pop()
            else:
                cnt = 0
                for i in range(len(q) - 1, 0, -1):
                    if q[i] == q[0]:
                        cnt += 1
                        q.rotate(-i)
                        res += i
                        break
                if cnt == 0:
                    q.rotate(-1)
                    res += 1
        return res