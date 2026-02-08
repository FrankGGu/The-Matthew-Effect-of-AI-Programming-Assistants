struct Solution;

impl Solution {
    pub fn solve_sudoku(board: &mut Vec<Vec<char>>) {
        Self::backtrack(board, 0, 0);
    }

    fn backtrack(board: &mut Vec<Vec<char>>, row: usize, col: usize) -> bool {
        if row == 9 {
            return true;
        }

        let next_row = if col == 8 { row + 1 } else { row };
        let next_col = if col == 8 { 0 } else { col + 1 };

        if board[row][col] != '.' {
            return Self::backtrack(board, next_row, next_col);
        }

        for c in '1'..='9' {
            if Self::is_valid(board, row, col, c) {
                board[row][col] = c;
                if Self::backtrack(board, next_row, next_col) {
                    return true;
                }
                board[row][col] = '.';
            }
        }

        false
    }

    fn is_valid(board: &Vec<Vec<char>>, row: usize, col: usize, c: char) -> bool {
        for i in 0..9 {
            if board[row][i] == c || board[i][col] == c {
                return false;
            }
        }

        let box_row = (row / 3) * 3;
        let box_col = (col / 3) * 3;

        for i in 0..3 {
            for j in 0..3 {
                if board[box_row + i][box_col + j] == c {
                    return false;
                }
            }
        }

        true
    }
}