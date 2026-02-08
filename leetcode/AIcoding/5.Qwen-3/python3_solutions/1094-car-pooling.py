from typing import List

class Solution:
    def carPooling(self, trips: List[List[int]], capacity: int) -> bool:
        time = [0] * 1001
        for trip in trips:
            num, start, end = trip
            time[start] += num
            time[end] -= num
        current = 0
        for t in time:
            current += t
            if current > capacity:
                return False
        return True