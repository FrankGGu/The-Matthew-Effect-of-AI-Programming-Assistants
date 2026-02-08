class Solution:
    def get_kth(self, n, k):
        return int(n ** (1.0 / k))

    def smallestGoodSubarray(self, nums):
        from collections import defaultdict
        count = defaultdict(int)
        left = 0
        result = float('inf')
        for right in range(len(nums)):
            count[nums[right]] += 1
            while len(count) == 2:
                if nums[left] == nums[right]:
                    count[nums[left]] -= 1
                    if count[nums[left]] == 0:
                        del count[nums[left]]
                    left += 1
                else:
                    break
            result = min(result, right - left + 1)
        return result

    def smallestGoodBase(self, n: str) -> str:
        n = int(n)
        max_k = int(n ** 0.5) + 1
        for k in range(2, max_k + 1):
            low = 2
            high = n
            while low <= high:
                mid = (low + high) // 2
                total = 0
                for i in range(k):
                    total += mid ** i
                    if total > n:
                        break
                if total == n:
                    return str(mid)
                elif total < n:
                    low = mid + 1
                else:
                    high = mid - 1
        return str(n)