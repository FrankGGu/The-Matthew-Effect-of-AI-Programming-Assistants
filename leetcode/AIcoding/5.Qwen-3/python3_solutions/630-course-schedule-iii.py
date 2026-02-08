import heapq

class Solution:
    def scheduleCourse(self, courses: List[List[int]]) -> int:
        courses.sort(key=lambda x: x[1])
        max_heap = []
        time = 0
        for duration, end in courses:
            if time + duration <= end:
                heapq.heappush(max_heap, -duration)
                time += duration
            else:
                if max_heap and -max_heap[0] > duration:
                    time += heapq.heappop(max_heap) + duration
                    heapq.heappush(max_heap, -duration)
        return len(max_heap)