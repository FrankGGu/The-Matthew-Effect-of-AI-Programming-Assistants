class Solution:
    def getWinner(self, arr: List[int], k: int) -> int:
        from collections import deque
        q = deque(arr)
        while True:
            a = q.popleft()
            b = q.popleft()
            if a > b:
                q.appendleft(a)
                q.append(b)
                if len(q) == 1:
                    return a
            else:
                q.appendleft(b)
                q.append(a)
                if len(q) == 1:
                    return b