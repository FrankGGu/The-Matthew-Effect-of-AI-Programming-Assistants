class Solution:
    def beautifulPairs(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        count = 0
        freq = defaultdict(int)
        for num in nums:
            remainder = num % k
            complement = (k - remainder) % k
            count += freq[complement]
            freq[remainder] += 1
        return count