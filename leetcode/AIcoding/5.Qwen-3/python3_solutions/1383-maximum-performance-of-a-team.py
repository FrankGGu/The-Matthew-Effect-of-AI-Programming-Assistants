import heapq

class Solution:
    def maxPerformance(self, n: int, speed: List[int], efficiency: List[int], k: int) -> int:
        pairs = list(zip(efficiency, speed))
        pairs.sort(reverse=True)

        max_performance = 0
        min_heap = []
        total_speed = 0

        for eff, spd in pairs:
            if len(min_heap) >= k:
                total_speed -= heapq.heappop(min_heap)
            heapq.heappush(min_heap, spd)
            total_speed += spd
            max_performance = max(max_performance, total_speed * eff)

        return max_performance