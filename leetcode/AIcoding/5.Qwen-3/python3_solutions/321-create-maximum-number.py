from typing import List

class Solution:
    def maxNumber(self, nums1: List[int], nums2: List[int], k: int) -> List[int]:
        def merge(a, b):
            result = []
            while a or b:
                if a > b:
                    result.append(a[0])
                    a = a[1:]
                else:
                    result.append(b[0])
                    b = b[1:]
            return result

        def get_max_subsequence(nums, k):
            stack = []
            to_remove = len(nums) - k
            for num in nums:
                while to_remove > 0 and stack and stack[-1] < num:
                    stack.pop()
                    to_remove -= 1
                stack.append(num)
            return stack[:k]

        max_result = []
        for i in range(max(0, k - len(nums2)), min(k, len(nums1)) + 1):
            sub1 = get_max_subsequence(nums1, i)
            sub2 = get_max_subsequence(nums2, k - i)
            current = merge(sub1, sub2)
            if current > max_result:
                max_result = current
        return max_result