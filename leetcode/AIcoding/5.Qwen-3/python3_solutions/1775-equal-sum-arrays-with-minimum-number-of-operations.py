from typing import List

class Solution:
    def minOperations(self, nums1: List[int], nums2: List[int]) -> int:
        sum1 = sum(nums1)
        sum2 = sum(nums2)

        if sum1 == sum2:
            return 0

        if sum1 > sum2:
            nums1, nums2 = nums2, nums1
            sum1, sum2 = sum2, sum1

        diff = sum2 - sum1

        from collections import Counter

        count = Counter()

        for num in nums1:
            count[num] += 1

        for num in nums2:
            count[num] += 1

        keys = sorted(count.keys(), reverse=True)

        res = 0

        for key in keys:
            if diff <= 0:
                break
            if key < 6:
                max_decrease = 6 - key
                num_ops = diff // max_decrease
                if diff % max_decrease != 0:
                    num_ops += 1
                res += num_ops
                diff -= max_decrease * num_ops
            else:
                max_increase = key - 1
                num_ops = diff // max_increase
                if diff % max_increase != 0:
                    num_ops += 1
                res += num_ops
                diff -= max_increase * num_ops

        return res if diff <= 0 else -1