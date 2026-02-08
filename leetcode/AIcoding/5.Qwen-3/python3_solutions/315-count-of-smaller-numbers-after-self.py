class Solution:
    def countSmaller(self, nums: List[int]) -> List[int]:
        from bisect import bisect_left, insort

        result = []
        sorted_list = []

        for num in reversed(nums):
            index = bisect_left(sorted_list, num)
            result.append(index)
            insort(sorted_list, num)

        return result[::-1]