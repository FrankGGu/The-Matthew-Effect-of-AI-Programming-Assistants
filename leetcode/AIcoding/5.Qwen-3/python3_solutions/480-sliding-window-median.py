import heapq

class Solution:
    def medianSlidingWindow(self, nums: list[int], k: int) -> list[float]:
        max_heap = []  # lower half, stored as negatives
        min_heap = []  # upper half
        result = []

        for i in range(len(nums)):
            num = nums[i]

            if not max_heap or num <= -max_heap[0]:
                heapq.heappush(max_heap, -num)
            else:
                heapq.heappush(min_heap, num)

            # Balance heaps
            if len(max_heap) > len(min_heap) + 1:
                val = -heapq.heappop(max_heap)
                heapq.heappush(min_heap, val)
            elif len(min_heap) > len(max_heap):
                val = heapq.heappop(min_heap)
                heapq.heappush(max_heap, -val)

            # Remove elements out of the window
            if i >= k:
                out_num = nums[i - k]
                if out_num <= -max_heap[0]:
                    # Remove from max_heap
                    idx = max_heap.index(-out_num)
                    max_heap[idx] = max_heap[-1]
                    max_heap.pop()
                    if idx < len(max_heap):
                        heapq._siftup_max(max_heap, idx)
                        heapq._siftdown_max(max_heap, idx)
                else:
                    # Remove from min_heap
                    idx = min_heap.index(out_num)
                    min_heap[idx] = min_heap[-1]
                    min_heap.pop()
                    if idx < len(min_heap):
                        heapq._siftup(min_heap, idx)
                        heapq._siftdown(min_heap, idx)

                # Rebalance heaps
                if len(max_heap) > len(min_heap) + 1:
                    val = -heapq.heappop(max_heap)
                    heapq.heappush(min_heap, val)
                elif len(min_heap) > len(max_heap):
                    val = heapq.heappop(min_heap)
                    heapq.heappush(max_heap, -val)

            # Calculate median
            if i >= k - 1:
                if k % 2 == 0:
                    median = (-max_heap[0] + min_heap[0]) / 2
                else:
                    median = -max_heap[0]
                result.append(median)

        return result