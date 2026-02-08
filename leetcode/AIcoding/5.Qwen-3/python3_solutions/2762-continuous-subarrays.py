from typing import List

class Solution:
    def continuousSubarrays(self, nums: List[int]) -> int:
        from collections import defaultdict

        count = 0
        left = 0
        min_count = defaultdict(int)
        max_count = defaultdict(int)

        for right in range(len(nums)):
            min_count[nums[right]] += 1
            max_count[nums[right]] += 1

            while max(min_count.keys()) - min(min_count.keys()) > 2:
                min_count[nums[left]] -= 1
                if min_count[nums[left]] == 0:
                    del min_count[nums[left]]
                max_count[nums[left]] -= 1
                if max_count[nums[left]] == 0:
                    del max_count[nums[left]]
                left += 1

            count += right - left + 1

        return count