struct Solution;

impl Solution {
    pub fn num_rook_captures(board: Vec<Vec<char>>) -> i32 {
        let mut rook_pos = (0, 0);
        for i in 0..8 {
            for j in 0..8 {
                if board[i][j] == 'r' {
                    rook_pos = (i, j);
                    break;
                }
            }
        }

        let (x, y) = rook_pos;
        let mut count = 0;

        // Up
        for i in (0..x).rev() {
            if board[i][y] == 'p' {
                count += 1;
                break;
            } else if board[i][y] == 'B' {
                break;
            }
        }

        // Down
        for i in x + 1..8 {
            if board[i][y] == 'p' {
                count += 1;
                break;
            } else if board[i][y] == 'B' {
                break;
            }
        }

        // Left
        for j in (0..y).rev() {
            if board[x][j] == 'p' {
                count += 1;
                break;
            } else if board[x][j] == 'B' {
                break;
            }
        }

        // Right
        for j in y + 1..8 {
            if board[x][j] == 'p' {
                count += 1;
                break;
            } else if board[x][j] == 'B' {
                break;
            }
        }

        count
    }
}