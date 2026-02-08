class Solution:
    def maximumAndMinimumSubarraySums(self, nums: List[int], k: int) -> Tuple[int, int]:
        from collections import deque

        max_sum = float('-inf')
        min_sum = float('inf')

        prefix = [0]
        for num in nums:
            prefix.append(prefix[-1] + num)

        dq_max = deque()
        dq_min = deque()

        for i in range(k, len(prefix)):
            while dq_max and prefix[i] >= prefix[dq_max[-1]]:
                dq_max.pop()
            dq_max.append(i)
            while dq_max[0] <= i - k:
                dq_max.popleft()

            while dq_min and prefix[i] <= prefix[dq_min[-1]]:
                dq_min.pop()
            dq_min.append(i)
            while dq_min[0] <= i - k:
                dq_min.popleft()

            max_sum = max(max_sum, prefix[dq_max[0]] - prefix[i - k])
            min_sum = min(min_sum, prefix[dq_min[0]] - prefix[i - k])

        return (max_sum, min_sum)