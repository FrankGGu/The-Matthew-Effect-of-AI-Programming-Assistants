class Solution:
    def kthLargestValue(self, matrix: List[List[int]], k: int) -> int:
        m, n = len(matrix), len(matrix[0])
        dp = [[0] * n for _ in range(m)]
        max_heap = []

        for i in range(m):
            for j in range(n):
                if i == 0 and j == 0:
                    dp[i][j] = matrix[i][j]
                elif i == 0:
                    dp[i][j] = dp[i][j-1] ^ matrix[i][j]
                elif j == 0:
                    dp[i][j] = dp[i-1][j] ^ matrix[i][j]
                else:
                    dp[i][j] = dp[i-1][j] ^ dp[i][j-1] ^ matrix[i][j]
                heapq.heappush(max_heap, -dp[i][j])

        for _ in range(k-1):
            heapq.heappop(max_heap)

        return -heapq.heappop(max_heap)