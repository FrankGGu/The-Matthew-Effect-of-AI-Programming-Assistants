struct Solution;

impl Solution {
    pub fn place_word_in_crossword(board: Vec<Vec<char>>, word: String) -> bool {
        let n = board.len();
        let m = board[0].len();
        let word_len = word.len();

        for i in 0..n {
            for j in 0..m {
                if board[i][j] == ' ' || board[i][j] == word.chars().next().unwrap() {
                    if check_horizontal(&board, &word, i, j) || check_vertical(&board, &word, i, j) {
                        return true;
                    }
                }
            }
        }

        false
    }

    fn check_horizontal(board: &Vec<Vec<char>>, word: &String, row: usize, col: usize) -> bool {
        let n = board.len();
        let m = board[0].len();
        let word_len = word.len();

        if col + word_len > m {
            return false;
        }

        let mut valid = true;
        for i in 0..word_len {
            let c = board[row][col + i];
            if c != ' ' && c != word.chars().nth(i).unwrap() {
                valid = false;
                break;
            }
        }

        if valid {
            return true;
        }

        if col > 0 && board[row][col - 1] != ' ' {
            return false;
        }

        if col + word_len < m && board[row][col + word_len] != ' ' {
            return false;
        }

        valid
    }

    fn check_vertical(board: &Vec<Vec<char>>, word: &String, row: usize, col: usize) -> bool {
        let n = board.len();
        let m = board[0].len();
        let word_len = word.len();

        if row + word_len > n {
            return false;
        }

        let mut valid = true;
        for i in 0..word_len {
            let c = board[row + i][col];
            if c != ' ' && c != word.chars().nth(i).unwrap() {
                valid = false;
                break;
            }
        }

        if valid {
            return true;
        }

        if row > 0 && board[row - 1][col] != ' ' {
            return false;
        }

        if row + word_len < n && board[row + word_len][col] != ' ' {
            return false;
        }

        valid
    }
}