class Solution:
    def minimizeMaximum(self, nums1: List[int], nums2: List[int]) -> int:
        from collections import deque

        nums1.sort()
        nums2.sort()

        q1 = deque(nums1)
        q2 = deque(nums2)

        res = 0

        while q1 and q2:
            if q1[0] <= q2[0]:
                res = max(res, q1.popleft())
            else:
                res = max(res, q2.popleft())

        while q1:
            res = max(res, q1.popleft())
        while q2:
            res = max(res, q2.popleft())

        return res