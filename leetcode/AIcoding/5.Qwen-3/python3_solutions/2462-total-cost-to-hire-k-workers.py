class Solution:
    def totalCost(self, costs: List[int], k: int, candidates: int) -> int:
        import heapq

        n = len(costs)
        left = 0
        right = n - 1
        heap_left = []
        heap_right = []
        total_cost = 0

        for _ in range(candidates):
            if left <= right:
                heapq.heappush(heap_left, costs[left])
                left += 1
            if left <= right:
                heapq.heappush(heap_right, costs[right])
                right -= 1

        for _ in range(k):
            if not heap_left:
                total_cost += heapq.heappop(heap_right)
            elif not heap_right:
                total_cost += heapq.heappop(heap_left)
            else:
                if heap_left[0] <= heap_right[0]:
                    total_cost += heapq.heappop(heap_left)
                    if left <= right:
                        heapq.heappush(heap_left, costs[left])
                        left += 1
                else:
                    total_cost += heapq.heappop(heap_right)
                    if left <= right:
                        heapq.heappush(heap_right, costs[right])
                        right -= 1

        return total_cost