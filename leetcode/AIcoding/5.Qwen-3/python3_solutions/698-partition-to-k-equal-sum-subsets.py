class Solution:
    def canPartitionKSubsets(self, nums, k):
        total = sum(nums)
        if total % k != 0:
            return False
        target = total // k
        nums.sort(reverse=True)
        if nums[0] > target:
            return False
        used = [False] * len(nums)

        def backtrack(start, current_sum, count):
            if count == k:
                return True
            if current_sum == target:
                return backtrack(0, 0, count + 1)
            for i in range(start, len(nums)):
                if not used[i] and current_sum + nums[i] <= target:
                    used[i] = True
                    if backtrack(i + 1, current_sum + nums[i], count):
                        return True
                    used[i] = False
            return False

        return backtrack(0, 0, 0)