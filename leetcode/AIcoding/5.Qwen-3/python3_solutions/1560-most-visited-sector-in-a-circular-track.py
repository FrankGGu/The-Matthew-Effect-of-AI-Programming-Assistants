from collections import defaultdict
from typing import List

class Solution:
    def mostVisited(self, n: int, rounds: List[int]) -> List[int]:
        count = defaultdict(int)
        for i in range(1, len(rounds)):
            start = rounds[i - 1]
            end = rounds[i]
            if start <= end:
                for j in range(start, end + 1):
                    count[j] += 1
            else:
                for j in range(start, n + 1):
                    count[j] += 1
                for j in range(1, end + 1):
                    count[j] += 1
        max_visits = max(count.values())
        return [k for k, v in count.items() if v == max_visits]