class Solution:
    def shortestSuperstring(self, A: List[str]) -> str:
        n = len(A)
        cost = [[0] * n for _ in range(n)]
        for i in range(n):
            for j in range(n):
                if i != j:
                    a, b = A[i], A[j]
                    k = min(len(a), len(b))
                    while k > 0:
                        if a[-k:] == b[:k]:
                            cost[i][j] = k
                            break
                        k -= 1

        dp = [[float('inf')] * n for _ in range(1 << n)]
        prev = [[-1] * n for _ in range(1 << n)]

        for i in range(n):
            dp[1 << i][i] = len(A[i])

        for mask in range(1 << n):
            for last in range(n):
                if not (mask & (1 << last)):
                    continue
                for i in range(n):
                    if mask & (1 << i):
                        continue
                    new_mask = mask | (1 << i)
                    if dp[mask][last] + cost[last][i] < dp[new_mask][i]:
                        dp[new_mask][i] = dp[mask][last] + cost[last][i]
                        prev[new_mask][i] = last

        end = -1
        min_len = float('inf')
        for i in range(n):
            if dp[(1 << n) - 1][i] < min_len:
                min_len = dp[(1 << n) - 1][i]
                end = i

        result = []
        mask = (1 << n) - 1
        while end != -1:
            result.append(A[end])
            next_end = prev[mask][end]
            mask ^= (1 << end)
            end = next_end

        result.reverse()
        res = result[0]
        for i in range(1, len(result)):
            res += result[i][cost[result.index(res)][result.index(result[i])]:]

        return res