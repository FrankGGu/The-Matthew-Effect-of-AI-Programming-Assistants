impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_score(card_points: Vec<i32>, k: i32) -> i32 {
        let n = card_points.len();
        let k = k as usize;

        let mut total = 0;
        for i in 0..k {
            total += card_points[i];
        }

        let mut max_score = total;

        for i in 1..=k {
            total = total - card_points[k - i] + card_points[n - i];
            max_score = max(max_score, total);
        }

        max_score
    }
}
}