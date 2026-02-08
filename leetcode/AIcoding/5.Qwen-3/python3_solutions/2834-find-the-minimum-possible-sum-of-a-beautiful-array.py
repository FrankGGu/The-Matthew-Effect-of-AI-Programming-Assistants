class Solution:
    def findMinPossibleSum(self, n: int, k: int) -> int:
        from collections import deque

        def is_beautiful(arr):
            seen = set()
            for num in arr:
                if num in seen:
                    return False
                seen.add(num)
            return True

        def generate_beautiful_array(n, k):
            result = []
            used = [False] * (n + 1)
            queue = deque([[]])
            while queue:
                current = queue.popleft()
                if len(current) == n:
                    return current
                for i in range(1, n + 1):
                    if not used[i]:
                        if not current or abs(i - current[-1]) != k:
                            used[i] = True
                            current.append(i)
                            queue.append(current[:])
                            current.pop()
                            used[i] = False
            return []

        beautiful_array = generate_beautiful_array(n, k)
        return sum(beautiful_array)