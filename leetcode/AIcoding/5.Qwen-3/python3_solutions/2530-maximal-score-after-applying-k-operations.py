class Solution:
    def maxScore(self, nums: List[int], k: int) -> int:
        import heapq
        max_heap = []
        for num in nums:
            heapq.heappush(max_heap, -num)
        score = 0
        for _ in range(k):
            max_val = -heapq.heappop(max_heap)
            score += max_val
            heapq.heappush(max_heap, -(max_val // 2))
        return score