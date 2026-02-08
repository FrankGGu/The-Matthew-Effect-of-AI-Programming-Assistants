class Solution:
    def findStudent(self, students: list[str], target: str) -> int:
        for i, student in enumerate(students):
            if student == target:
                return i
        return -1