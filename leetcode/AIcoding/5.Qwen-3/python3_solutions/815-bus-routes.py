from collections import defaultdict, deque
class Solution:
    def numBusesToDestination(self, routes: List[List[int]], source: int, target: int) -> int:
        if source == target:
            return 0
        route_stop = defaultdict(list)
        for i, stops in enumerate(routes):
            for stop in stops:
                route_stop[stop].append(i)
        visited_routes = set()
        visited_stops = set()
        queue = deque()
        for route in route_stop[source]:
            queue.append((route, 1))
            visited_routes.add(route)
        while queue:
            current_route, buses = queue.popleft()
            for stop in routes[current_route]:
                if stop == target:
                    return buses
                for next_route in route_stop[stop]:
                    if next_route not in visited_routes:
                        visited_routes.add(next_route)
                        queue.append((next_route, buses + 1))
        return -1