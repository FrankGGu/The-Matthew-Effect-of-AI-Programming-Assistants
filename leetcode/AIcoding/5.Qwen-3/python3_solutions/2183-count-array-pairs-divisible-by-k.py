from typing import List
from collections import defaultdict

class Solution:
    def countPairs(self, nums: List[int], k: int) -> int
        mod_count = defaultdict(int)
        result = 0
        for num in nums:
            rem = num % k
            complement = (k - rem) % k
            result += mod_count[complement]
            mod_count[rem] += 1
        return result