class Solution:
    def minimizeMax(self, nums: List[int], p: int) -> int:
        nums.sort()
        n = len(nums)

        def count_pairs(max_diff):
            count = 0
            i = 0
            while i < n - 1:
                if nums[i + 1] - nums[i] <= max_diff:
                    count += 1
                    i += 2
                else:
                    i += 1
            return count

        left, right = 0, nums[-1] - nums[0]
        answer = right

        while left <= right:
            mid = (left + right) // 2
            if count_pairs(mid) >= p:
                answer = mid
                right = mid - 1
            else:
                left = mid + 1

        return answer