from typing import List

class Solution:
    def maximumDistanceInArrays(self, arrays: List[List[int]]) -> int:
        min_val = arrays[0][0]
        max_val = arrays[0][-1]
        result = 0
        for i in range(1, len(arrays)):
            current_min = arrays[i][0]
            current_max = arrays[i][-1]
            result = max(result, current_max - min_val, max_val - current_min)
            min_val = min(min_val, current_min)
            max_val = max(max_val, current_max)
        return result