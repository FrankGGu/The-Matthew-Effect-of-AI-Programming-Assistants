struct Solution;

impl Solution {
    pub fn substr_count(s: String, c: char) -> i32 {
        let mut count = 0;
        let mut total = 0;

        for ch in s.chars() {
            if ch == c {
                count += 1;
            }
            total += count;
        }

        total
    }
}