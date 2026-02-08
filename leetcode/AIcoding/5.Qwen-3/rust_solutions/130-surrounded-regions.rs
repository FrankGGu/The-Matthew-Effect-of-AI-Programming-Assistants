struct Solution;

impl Solution {
    pub fn solve(board: &mut Vec<Vec<char>>) {
        if board.is_empty() || board[0].is_empty() {
            return;
        }

        let rows = board.len();
        let cols = board[0].len();

        let mut visited = vec![vec![false; cols]; rows];

        for i in 0..rows {
            if board[i][0] == 'O' && !visited[i][0] {
                self::dfs(board, &mut visited, i, 0);
            }
            if board[i][cols - 1] == 'O' && !visited[i][cols - 1] {
                self::dfs(board, &mut visited, i, cols - 1);
            }
        }

        for j in 0..cols {
            if board[0][j] == 'O' && !visited[0][j] {
                self::dfs(board, &mut visited, 0, j);
            }
            if board[rows - 1][j] == 'O' && !visited[rows - 1][j] {
                self::dfs(board, &mut visited, rows - 1, j);
            }
        }

        for i in 0..rows {
            for j in 0..cols {
                if !visited[i][j] {
                    board[i][j] = 'X';
                }
            }
        }
    }

    fn dfs(board: &mut Vec<Vec<char>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize) {
        if i < 0 || i >= board.len() || j < 0 || j >= board[0].len() || board[i][j] != 'O' || visited[i][j] {
            return;
        }

        visited[i][j] = true;

        Self::dfs(board, visited, i + 1, j);
        Self::dfs(board, visited, i - 1, j);
        Self::dfs(board, visited, i, j + 1);
        Self::dfs(board, visited, i, j - 1);
    }
}