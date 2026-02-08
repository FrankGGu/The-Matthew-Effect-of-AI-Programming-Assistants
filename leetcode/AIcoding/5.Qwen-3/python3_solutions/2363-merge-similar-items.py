from collections import defaultdict
from typing import List

class Solution:
    def mergeSimilarItems(self, items1: List[List[int], int], items2: List[List[int], int]) -> List[List[int], int]:
        map = defaultdict(int)
        for item in items1:
            map[item[0]] += item[1]
        for item in items2:
            map[item[0]] += item[1]
        return [[k, v] for k, v in map.items()]