struct Solution;

impl Solution {
    pub fn max_depth_after_split(input: String) -> Vec<i32> {
        let mut result = vec![0; input.len()];
        let mut depth = 0;
        for (i, c) in input.chars().enumerate() {
            if c == '(' {
                depth += 1;
                result[i] = depth;
            } else {
                result[i] = depth;
                depth -= 1;
            }
        }
        result
    }
}