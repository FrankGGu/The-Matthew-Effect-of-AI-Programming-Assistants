struct Solution;

impl Solution {
    pub fn time_needed_to_rearrange(binary: String) -> i64 {
        let mut count = 0;
        let mut prev = '0';
        for c in binary.chars() {
            if c == '1' && prev == '0' {
                count += 1;
            }
            prev = c;
        }
        count
    }
}