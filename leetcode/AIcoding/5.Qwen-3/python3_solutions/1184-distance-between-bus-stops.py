class Solution:
    def distanceBetweenBusStops(self, distance: List[int], start: int, end: int) -> int:
        if start > end:
            start, end = end, start
        clockwise = sum(distance[start:end])
        counter_clockwise = sum(distance[end:] + distance[:start])
        return min(clockwise, counter_clockwise)