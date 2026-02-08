from typing import List

class Solution:
    def isPrefixString(self, nums: List[int], s: str) -> bool:
        res = ""
        for num in nums:
            res += str(num)
            if res == s:
                return True
        return False