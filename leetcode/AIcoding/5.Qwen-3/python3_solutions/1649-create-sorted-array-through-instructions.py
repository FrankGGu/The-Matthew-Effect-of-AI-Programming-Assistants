class Solution:
    def createSortedArray(self, instructions: List[int]) -> int:
        from bisect import bisect_left, bisect_right

        arr = []
        res = 0
        for num in instructions:
            left = bisect_left(arr, num)
            right = bisect_right(arr, num)
            res += min(left, len(arr) - right)
            arr.insert(left, num)
        return res