class Solution:
    def closestRoom(self, roomId: List[int], position: List[int], queries: List[List[int]]) -> List[int]:
        import heapq

        n = len(roomId)
        rooms = list(zip(position, roomId))
        rooms.sort()
        m = len(queries)
        queries = sorted([(i, pos, r) for i, (pos, r) in enumerate(queries)], key=lambda x: x[1])

        res = [0] * m
        heap = []
        idx = 0

        for i, pos, r in queries:
            while idx < n and rooms[idx][0] <= pos:
                heapq.heappush(heap, (-abs(rooms[idx][0] - pos), rooms[idx][1]))
                idx += 1
            if not heap:
                res[i] = r
            else:
                dist, room = heap[0]
                res[i] = room

        return res