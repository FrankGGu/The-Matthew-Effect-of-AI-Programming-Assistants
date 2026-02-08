from collections import defaultdict

class Solution:
    def countCompleteSubarrays(self, nums: List[int]) -> int:
        unique = len(set(nums))
        count = 0
        freq = defaultdict(int)
        left = 0
        for right in range(len(nums)):
            freq[nums[right]] += 1
            while len(freq) == unique:
                freq[nums[left]] -= 1
                if freq[nums[left]] == 0:
                    del freq[nums[left]]
                left += 1
            count += left
        return count