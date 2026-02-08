class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        seen = set()
        for i in range(9):
            for j in range(9):
                num = board[i][j]
                if num != '.':
                    row = f"row{i}{num}"
                    col = f"col{j}{num}"
                    box = f"box{(i//3)*3 + j//3}{num}"
                    if row in seen or col in seen or box in seen:
                        return False
                    seen.add(row)
                    seen.add(col)
                    seen.add(box)
        return True