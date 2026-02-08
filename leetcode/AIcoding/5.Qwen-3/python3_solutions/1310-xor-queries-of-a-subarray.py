from typing import List

class Solution:
    def subarrayXOR(self, arr: List[int], queries: List[List[int]]) -> List[int]:
        prefix = [0]
        for num in arr:
            prefix.append(prefix[-1] ^ num)
        res = []
        for l, r in queries:
            res.append(prefix[r + 1] ^ prefix[l])
        return res