class Solution:
    def countLargestGroup(self, n: int) -> int:
        from collections import defaultdict

        groups = defaultdict(int)
        for i in range(1, n + 1):
            digit_sum = sum(int(d) for d in str(i))
            groups[digit_sum] += 1

        max_size = max(groups.values())
        return sum(1 for v in groups.values() if v == max_size)