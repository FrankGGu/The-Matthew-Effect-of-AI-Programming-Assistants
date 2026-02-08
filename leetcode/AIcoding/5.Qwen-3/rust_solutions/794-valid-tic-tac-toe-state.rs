impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn valid_tic_tac_toe(board: Vec<String>) -> bool {
        let mut count_x = 0;
        let mut count_o = 0;
        let mut win_x = false;
        let mut win_o = false;

        for row in &board {
            for c in row.chars() {
                if c == 'X' {
                    count_x += 1;
                } else if c == 'O' {
                    count_o += 1;
                }
            }
        }

        if count_x < count_o || count_x > count_o + 1 {
            return false;
        }

        for i in 0..3 {
            if board[i].chars().nth(0) == Some('X') && board[i].chars().nth(1) == Some('X') && board[i].chars().nth(2) == Some('X') {
                win_x = true;
            }
            if board[i].chars().nth(0) == Some('O') && board[i].chars().nth(1) == Some('O') && board[i].chars().nth(2) == Some('O') {
                win_o = true;
            }
        }

        for j in 0..3 {
            if board[0].chars().nth(j) == Some('X') && board[1].chars().nth(j) == Some('X') && board[2].chars().nth(j) == Some('X') {
                win_x = true;
            }
            if board[0].chars().nth(j) == Some('O') && board[1].chars().nth(j) == Some('O') && board[2].chars().nth(j) == Some('O') {
                win_o = true;
            }
        }

        if board[0].chars().nth(0) == Some('X') && board[1].chars().nth(1) == Some('X') && board[2].chars().nth(2) == Some('X') {
            win_x = true;
        }
        if board[0].chars().nth(0) == Some('O') && board[1].chars().nth(1) == Some('O') && board[2].chars().nth(2) == Some('O') {
            win_o = true;
        }

        if board[0].chars().nth(2) == Some('X') && board[1].chars().nth(1) == Some('X') && board[2].chars().nth(0) == Some('X') {
            win_x = true;
        }
        if board[0].chars().nth(2) == Some('O') && board[1].chars().nth(1) == Some('O') && board[2].chars().nth(0) == Some('O') {
            win_o = true;
        }

        if win_x && win_o {
            return false;
        }

        if win_x && count_x != count_o + 1 {
            return false;
        }

        if win_o && count_x != count_o {
            return false;
        }

        true
    }
}
}