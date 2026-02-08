struct Solution {}

impl Solution {
    pub fn judge_square_sum(c: i32) -> bool {
        let c = c as i64;
        let max_sqrt = (c as f64).sqrt() as i64;
        for a in 0..=max_sqrt {
            let a_sq = a * a;
            if a_sq > c {
                break;
            }
            let b_sq = c - a_sq;
            let b = (b_sq as f64).sqrt() as i64;
            if b * b == b_sq {
                return true;
            }
        }
        false
    }
}