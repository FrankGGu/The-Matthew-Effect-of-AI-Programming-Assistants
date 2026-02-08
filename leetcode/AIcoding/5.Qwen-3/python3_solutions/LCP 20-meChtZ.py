class Solution:
    def numBusesToLine(self, routes, source, target):
        from collections import defaultdict, deque

        route_map = defaultdict(list)
        for i, route in enumerate(routes):
            for stop in route:
                route_map[stop].append(i)

        visited_routes = set()
        visited_stops = set()
        queue = deque()

        queue.append(source)
        visited_stops.add(source)
        buses = 0

        while queue:
            for _ in range(len(queue)):
                current_stop = queue.popleft()
                if current_stop == target:
                    return buses
                for route_id in route_map[current_stop]:
                    if route_id not in visited_routes:
                        visited_routes.add(route_id)
                        for stop in routes[route_id]:
                            if stop not in visited_stops:
                                visited_stops.add(stop)
                                queue.append(stop)
            buses += 1

        return -1