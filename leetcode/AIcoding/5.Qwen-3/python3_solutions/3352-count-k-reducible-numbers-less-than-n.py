class Solution:
    def countKReducible(self, n: int, k: int) -> int:
        from collections import deque

        if k == 0:
            return n

        max_len = len(bin(n)) - 2
        dp = [0] * (max_len + 1)
        dp[0] = 1

        for i in range(1, max_len + 1):
            dp[i] = dp[i - 1] * 2

        result = 0
        queue = deque([0])

        while queue:
            num = queue.popleft()
            if num > n:
                continue
            if num != 0:
                result += 1
            for i in range(1, k + 1):
                next_num = num * 2 + 1
                if next_num <= n:
                    queue.append(next_num)

        return result