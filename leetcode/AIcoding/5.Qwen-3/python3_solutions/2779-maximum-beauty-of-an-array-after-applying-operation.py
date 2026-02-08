class Solution:
    def maximumBeauty(self, nums: List[int], k: int) -> int:
        events = []
        for num in nums:
            events.append((num - k, 1))
            events.append((num + k + 1, -1))

        events.sort()

        max_beauty = 0
        current = 0
        for time, delta in events:
            current += delta
            max_beauty = max(max_beauty, current)

        return max_beauty