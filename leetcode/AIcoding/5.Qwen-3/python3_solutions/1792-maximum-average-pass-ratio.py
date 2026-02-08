import heapq

class Solution:
    def maxAveragePassRatio(self, teachers: List[List[int]], k: int) -> float:
        heap = []
        for pass_num, total in teachers:
            diff = (pass_num + 1) / (total + 1) - pass_num / total
            heapq.heappush(heap, (-diff, pass_num, total))

        for _ in range(k):
            diff, pass_num, total = heapq.heappop(heap)
            pass_num += 1
            total += 1
            new_diff = (pass_num + 1) / (total + 1) - pass_num / total
            heapq.heappush(heap, (-new_diff, pass_num, total))

        total_pass_ratio = 0.0
        for _, pass_num, total in heap:
            total_pass_ratio += pass_num / total

        return total_pass_ratio / len(teachers)