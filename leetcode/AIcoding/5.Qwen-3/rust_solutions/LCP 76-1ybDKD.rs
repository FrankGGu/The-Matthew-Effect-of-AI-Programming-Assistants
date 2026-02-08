struct Solution;

impl Solution {
    pub fn total_moves_to_make_board_empty(n: i32) -> i32 {
        let mut moves = 0;
        let mut n = n;
        while n > 0 {
            moves += n;
            n /= 2;
        }
        moves
    }
}