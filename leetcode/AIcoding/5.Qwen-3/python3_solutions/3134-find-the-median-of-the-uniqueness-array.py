class Solution:
    def medianOfUniquenessArray(self, nums: list[int]) -> int:
        from collections import defaultdict

        def get_unique_subarrays_count(nums):
            n = len(nums)
            count = 0
            for i in range(n):
                unique = set()
                for j in range(i, n):
                    if nums[j] in unique:
                        break
                    unique.add(nums[j])
                    count += 1
            return count

        def generate_unique_subarrays(nums):
            n = len(nums)
            result = []
            for i in range(n):
                unique = set()
                for j in range(i, n):
                    if nums[j] in unique:
                        break
                    unique.add(nums[j])
                    result.append(nums[i:j+1])
            return result

        total = get_unique_subarrays_count(nums)
        subarrays = generate_unique_subarrays(nums)
        subarrays.sort()
        return subarrays[total // 2]