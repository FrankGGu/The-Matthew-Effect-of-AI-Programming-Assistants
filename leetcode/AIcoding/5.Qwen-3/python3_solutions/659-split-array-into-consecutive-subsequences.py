from collections import defaultdict

class Solution:
    def isPossible(self, nums: List[int]) -> bool:
        count = defaultdict(int)
        for num in nums:
            count[num] += 1

        for num in nums:
            if count[num] == 0:
                continue
            if count[num - 1] > 0 and count[num - 2] > 0:
                count[num - 1] -= 1
                count[num - 2] -= 1
                count[num] -= 1
            elif count[num + 1] > 0 and count[num + 2] > 0:
                count[num + 1] -= 1
                count[num + 2] -= 1
                count[num] -= 1
            else:
                return False
        return True