class Employee:
    def __init__(self, id: int, importance: int, subordinates: List[int]):
        self.id = id
        self.importance = importance
        self.subordinates = subordinates

class Solution:
    def getImportance(self, employees: List['Employee'], id: int) -> int:
        from collections import deque

        emp_dict = {emp.id: emp for emp in employees}
        total_importance = 0
        queue = deque([id])

        while queue:
            current_id = queue.popleft()
            current_emp = emp_dict[current_id]
            total_importance += current_emp.importance
            for sub_id in current_emp.subordinates:
                queue.append(sub_id)

        return total_importance