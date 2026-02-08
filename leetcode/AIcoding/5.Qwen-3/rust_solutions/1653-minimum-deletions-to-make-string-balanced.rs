struct Solution;

impl Solution {
    pub fn minimum_deletions(s: String) -> i32 {
        let mut count_a = 0;
        let mut count_b = 0;
        for c in s.chars() {
            if c == 'a' {
                count_a += 1;
            } else {
                count_b += 1;
            }
        }

        let mut left_a = 0;
        let mut right_b = 0;
        let mut min_deletions = std::i32::MAX;

        for c in s.chars() {
            if c == 'a' {
                left_a += 1;
            } else {
                right_b += 1;
            }

            let deletions = (count_a - left_a) + right_b;
            min_deletions = std::cmp::min(min_deletions, deletions);
        }

        min_deletions
    }
}