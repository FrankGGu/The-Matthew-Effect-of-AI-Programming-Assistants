class Solution:
    def countStudents(self, students: List[int], sandwiches: List[int]) -> int:
        from collections import deque

        queue = deque(students)
        sandwiches = deque(sandwiches)

        while queue and sandwiches:
            if queue[0] == sandwiches[0]:
                queue.popleft()
                sandwiches.popleft()
            else:
                break

        return len(queue)