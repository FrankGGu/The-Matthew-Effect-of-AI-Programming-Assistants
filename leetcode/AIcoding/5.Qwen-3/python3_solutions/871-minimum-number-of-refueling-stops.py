class Solution:
    def minRefuelStops(self, target: int, startFuel: int, stations: List[List[int]]) -> int:
        import heapq
        stations.append((target, 0))
        heap = []
        prev = 0
        fuel = startFuel
        stops = 0
        for distance, capacity in stations:
            fuel -= distance - prev
            while fuel < 0 and heap:
                fuel += -heapq.heappop(heap)
                stops += 1
            if fuel < 0:
                return -1
            heapq.heappush(heap, -capacity)
            prev = distance
        return stops