class Solution:
    def minStalls(self, bookings: List[List[int]]) -> int:
        from collections import defaultdict

        events = defaultdict(int)
        for start, end in bookings:
            events[start] += 1
            events[end + 1] -= 1

        max_stalls = 0
        current_stalls = 0
        for time in sorted(events.keys()):
            current_stalls += events[time]
            max_stalls = max(max_stalls, current_stalls)

        return max_stalls