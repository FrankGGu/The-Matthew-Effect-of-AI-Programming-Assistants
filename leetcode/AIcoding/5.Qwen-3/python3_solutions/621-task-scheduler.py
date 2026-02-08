class Solution:
    def leastInterval(self, tasks: List[str], n: int) -> int:
        from collections import Counter

        task_counts = Counter(tasks)
        max_freq = max(task_counts.values())
        count_of_max_freq = sum(1 for freq in task_counts.values() if freq == max_freq)

        return max((max_freq - 1) * (n + 1) + count_of_max_freq, len(tasks))