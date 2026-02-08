from collections import Counter

class Solution:
    def isPossibleDivide(self, nums, k):
        if len(nums) % k != 0:
            return False
        count = Counter(nums)
        for num in sorted(count):
            if count[num] > 0:
                for i in range(k):
                    if count[num + i] < count[num]:
                        return False
                    count[num + i] -= count[num]
        return True