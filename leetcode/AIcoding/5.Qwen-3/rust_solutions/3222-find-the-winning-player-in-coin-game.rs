impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_winner(n: i32, x: i32, y: i32) -> String {
        let mut memo = HashMap::new();
        let mut player1_turn = true;
        let result = Self::can_win(n, x, y, &mut memo, player1_turn);
        if result {
            "Player 1".to_string()
        } else {
            "Player 2".to_string()
        }
    }

    fn can_win(n: i32, x: i32, y: i32, memo: &mut HashMap<(i32, bool), bool>, is_player1_turn: bool) -> bool {
        if n == 0 {
            return false;
        }

        let key = (n, is_player1_turn);
        if let Some(&result) = memo.get(&key) {
            return result;
        }

        let mut can_win = false;

        if n >= x && !Self::can_win(n - x, x, y, memo, !is_player1_turn) {
            can_win = true;
        } else if n >= y && !Self::can_win(n - y, x, y, memo, !is_player1_turn) {
            can_win = true;
        }

        memo.insert(key, can_win);
        can_win
    }
}
}