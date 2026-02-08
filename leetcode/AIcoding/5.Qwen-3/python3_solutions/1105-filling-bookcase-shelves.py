class Solution:
    def minHeightShelves(self, books: List[List[int]], shelfWidth: int) -> int:
        n = len(books)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            max_width = 0
            max_height = 0
            j = i - 1
            while j >= 0 and max_width + books[j][0] <= shelfWidth:
                max_width += books[j][0]
                max_height = max(max_height, books[j][1])
                dp[i] = min(dp[i], dp[j] + max_height)
                j -= 1

        return dp[n]