struct Solution;

impl Solution {
    pub fn min_penalty(shop: String) -> i32 {
        let mut total_penalty = 0;
        let mut y_count = 0;
        let mut n_count = 0;

        for c in shop.chars() {
            if c == 'Y' {
                y_count += 1;
            } else {
                n_count += 1;
            }
        }

        let mut min_penalty = y_count;
        let mut current_penalty = 0;

        for c in shop.chars() {
            if c == 'Y' {
                current_penalty += 1;
            } else {
                current_penalty -= 1;
            }

            min_penalty = std::cmp::min(min_penalty, current_penalty);
        }

        min_penalty
    }
}