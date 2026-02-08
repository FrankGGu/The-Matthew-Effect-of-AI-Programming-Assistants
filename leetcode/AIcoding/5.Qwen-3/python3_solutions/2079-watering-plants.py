class Solution:
    def wateringPlants(self, plants: List[int], capacity: int) -> int:
        steps = 0
        current_capacity = capacity
        for i, water in enumerate(plants):
            if current_capacity < water:
                steps += 2 * i
                current_capacity = capacity
            steps += 1
            current_capacity -= water
        return steps