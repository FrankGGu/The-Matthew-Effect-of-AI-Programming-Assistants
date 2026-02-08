struct Solution;

impl Solution {
    pub fn max_depth(s: String) -> i32 {
        let mut depth = 0;
        let mut max_depth = 0;
        for c in s.chars() {
            match c {
                '(' => {
                    depth += 1;
                    if depth > max_depth {
                        max_depth = depth;
                    }
                },
                ')' => {
                    depth -= 1;
                },
                _ => {}
            }
        }
        max_depth
    }
}