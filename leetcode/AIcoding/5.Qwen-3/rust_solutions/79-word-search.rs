struct Solution;

impl Solution {
    pub fn exist(board: Vec<Vec<char>>, word: String) -> bool {
        let mut board = board;
        let rows = board.len();
        let cols = board[0].len();
        let word = word.chars().collect::<Vec<char>>();

        for i in 0..rows {
            for j in 0..cols {
                if dfs(&mut board, &word, i, j, 0) {
                    return true;
                }
            }
        }

        false
    }
}

fn dfs(board: &mut Vec<Vec<char>>, word: &[char], row: usize, col: usize, index: usize) -> bool {
    if index == word.len() {
        return true;
    }

    if row >= board.len() || col >= board[0].len() || board[row][col] != word[index] {
        return false;
    }

    let temp = board[row][col];
    board[row][col] = '#';

    let res = dfs(board, word, row + 1, col, index + 1)
        || dfs(board, word, row - 1, col, index + 1)
        || dfs(board, word, row, col + 1, index + 1)
        || dfs(board, word, row, col - 1, index + 1);

    board[row][col] = temp;

    res
}