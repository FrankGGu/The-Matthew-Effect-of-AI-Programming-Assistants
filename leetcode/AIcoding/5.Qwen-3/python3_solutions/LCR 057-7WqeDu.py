class Solution:
    def containsNearbyAlmostDuplicate(self, nums: List[int], k: int, l: int) -> bool:
        if k < 0 or l < 0:
            return False
        bucket_size = l + 1
        buckets = {}
        for i in range(len(nums)):
            num = nums[i]
            bucket_id = num // bucket_size
            if bucket_id in buckets:
                return True
            if (bucket_id - 1) in buckets and abs(num - buckets[bucket_id - 1]) <= l:
                return True
            if (bucket_id + 1) in buckets and abs(num - buckets[bucket_id + 1]) <= l:
                return True
            buckets[bucket_id] = num
            if i >= k:
                del buckets[nums[i - k] // bucket_size]
        return False