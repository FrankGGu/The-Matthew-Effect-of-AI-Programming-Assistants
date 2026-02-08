from typing import List

class Solution:
    def maximumPoints(self, enemyArrows: List[int], points: List[int]) -> List[int]:
        n = len(enemyArrows)
        max_points = 0
        best_shot = [0] * n

        def backtrack(index, arrows_left, current_points, shot):
            nonlocal max_points, best_shot
            if index == n:
                if current_points > max_points:
                    max_points = current_points
                    best_shot[:] = shot[:]
                return
            # Try to shoot the current target
            if arrows_left >= enemyArrows[index]:
                shot[index] = enemyArrows[index]
                backtrack(index + 1, arrows_left - enemyArrows[index], current_points + points[index], shot)
                shot[index] = 0
            # Try not to shoot the current target
            backtrack(index + 1, arrows_left, current_points, shot)

        backtrack(0, sum(enemyArrows), 0, [0] * n)
        return best_shot