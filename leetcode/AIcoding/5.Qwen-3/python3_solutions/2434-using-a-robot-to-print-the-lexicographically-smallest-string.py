class Solution:
    def robotWithString(self, s: str) -> str:
        from collections import deque

        stack = []
        q = deque(s)
        min_heap = []

        for c in q:
            min_heap.append(c)

        min_heap.sort()

        while q:
            if not min_heap:
                break
            if q[0] == min_heap[0]:
                stack.append(q.popleft())
                min_heap.pop(0)
            else:
                stack.append(q.popleft())

        return ''.join(stack)