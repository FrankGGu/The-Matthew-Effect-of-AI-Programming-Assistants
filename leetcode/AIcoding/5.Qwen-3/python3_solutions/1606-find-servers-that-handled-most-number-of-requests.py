from collections import defaultdict, deque
import heapq

class Solution:
    def findHighestLoadedServers(self, servers: List[int], requests: List[List[int]]) -> List[int]:
        available_servers = [(load, idx) for idx, load in enumerate(servers)]
        heapq.heapify(available_servers)

        busy_servers = []
        result = [0] * len(servers)

        for time, req_id in enumerate(requests):
            # Free up servers that have finished processing requests
            while busy_servers and busy_servers[0][0] <= time:
                _, load, idx = heapq.heappop(busy_servers)
                heapq.heappush(available_servers, (load, idx))

            # Assign request to an available server
            if available_servers:
                load, idx = heapq.heappop(available_servers)
                result[idx] += 1
                heapq.heappush(busy_servers, (time + req_id[1], load, idx))

        max_requests = max(result)
        return [i for i, count in enumerate(result) if count == max_requests]