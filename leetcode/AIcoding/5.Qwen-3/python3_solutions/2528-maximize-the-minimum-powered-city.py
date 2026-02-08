class Solution:
    def maxDistance(self, nums: List[int], k: int) -> int:
        def can_place(dist):
            count = 1
            last = nums[0]
            for num in nums[1:]:
                if num - last >= dist:
                    count += 1
                    last = num
                    if count == k:
                        return True
            return count >= k

        nums.sort()
        left, right = 0, nums[-1] - nums[0]
        result = 0
        while left <= right:
            mid = (left + right) // 2
            if can_place(mid):
                result = mid
                left = mid + 1
            else:
                right = mid - 1
        return result