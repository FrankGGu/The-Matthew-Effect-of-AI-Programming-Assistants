class Solution:
    def minCost(self, startPos: List[int], startDir: int, homePos: List[int], homeDir: int, rowCosts: List[int], colCosts: List[int]) -> int:
        def move(dir, pos, cost):
            if dir == 0:
                return pos[0] - 1, cost[pos[0] - 1]
            elif dir == 1:
                return pos[0] + 1, cost[pos[0] + 1]
            elif dir == 2:
                return pos[1] - 1, cost[pos[1] - 1]
            else:
                return pos[1] + 1, cost[pos[1] + 1]

        total_cost = 0
        current_pos = startPos[:]
        current_dir = startDir

        while current_pos != homePos:
            if current_dir == 0 or current_dir == 1:
                if current_pos[0] < homePos[0]:
                    current_pos[0], cost = move(1, current_pos, rowCosts)
                    total_cost += cost
                elif current_pos[0] > homePos[0]:
                    current_pos[0], cost = move(0, current_pos, rowCosts)
                    total_cost += cost
                else:
                    current_dir = 2 if current_dir == 0 else 3
            else:
                if current_pos[1] < homePos[1]:
                    current_pos[1], cost = move(3, current_pos, colCosts)
                    total_cost += cost
                elif current_pos[1] > homePos[1]:
                    current_pos[1], cost = move(2, current_pos, colCosts)
                    total_cost += cost
                else:
                    current_dir = 0 if current_dir == 2 else 1

        return total_cost