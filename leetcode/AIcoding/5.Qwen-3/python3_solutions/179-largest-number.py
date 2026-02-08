from typing import List

class Solution:
    def largestNumber(self, nums: List[int]) -> str:
        from functools import cmp_to_key

        def compare(a, b):
            if a + b > b + a:
                return -1
            elif a + b < b + a:
                return 1
            else:
                return 0

        nums = list(map(str, nums))
        nums.sort(key=cmp_to_key(compare))
        result = ''.join(nums)
        return '0' if result[0] == '0' else result