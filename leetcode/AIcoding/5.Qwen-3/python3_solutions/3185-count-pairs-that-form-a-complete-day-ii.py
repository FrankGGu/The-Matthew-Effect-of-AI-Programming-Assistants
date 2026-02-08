class Solution:
    def countCompleteDayPairs(self, duration: List[int], k: int) -> int:
        from collections import defaultdict

        remainder_count = defaultdict(int)
        count = 0

        for d in duration:
            rem = d % k
            complement = (k - rem) % k
            count += remainder_count[complement]
            remainder_count[rem] += 1

        return count