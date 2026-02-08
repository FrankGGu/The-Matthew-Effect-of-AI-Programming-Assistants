class Solution:
    def main(self, arr: List[int], k: int) -> int:
        from collections import defaultdict

        n = len(arr)
        freq = defaultdict(int)
        for i in range(n):
            freq[i % k] += arr[i]

        max_sum = max(freq.values())
        total = sum(freq.values())
        return total - max_sum