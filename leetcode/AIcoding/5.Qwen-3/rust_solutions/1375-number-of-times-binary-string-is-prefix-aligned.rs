struct Solution;

impl Solution {
    pub fn number_of_time_binary_string_is_prefix_aligned(s: String) -> i32 {
        let mut count = 0;
        let mut max = 0;
        for (i, c) in s.chars().enumerate() {
            if c == '1' {
                max = std::cmp::max(max, i + 1);
            }
            if max == i + 1 {
                count += 1;
            }
        }
        count
    }
}