class Solution:
    def minAbsoluteDifference(self, nums: List[int], x: int) -> int:
        from bisect import bisect_left, insort

        sorted_list = []
        min_diff = float('inf')

        for num in nums:
            idx = bisect_left(sorted_list, num)
            if idx < len(sorted_list):
                min_diff = min(min_diff, abs(sorted_list[idx] - num))
            if idx > 0:
                min_diff = min(min_diff, abs(sorted_list[idx - 1] - num))
            insort(sorted_list, num)

        return min_diff