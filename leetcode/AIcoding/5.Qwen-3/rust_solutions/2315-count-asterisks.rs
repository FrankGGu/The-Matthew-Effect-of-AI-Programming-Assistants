struct Solution;

impl Solution {
    pub fn count_asterisks(s: String) -> i32 {
        let mut count = 0;
        let mut in_bar = false;
        for c in s.chars() {
            match c {
                '|' => in_bar = !in_bar,
                '*' if !in_bar => count += 1,
                _ => {}
            }
        }
        count
    }
}