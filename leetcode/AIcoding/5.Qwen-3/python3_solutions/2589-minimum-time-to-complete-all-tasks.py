from typing import List

class Solution:
    def earliestSecond(self, tasks: List[str]) -> int:
        from collections import defaultdict

        task_count = defaultdict(int)
        for task in tasks:
            task_count[task] += 1

        max_count = max(task_count.values())
        return max_count * 2 - 1