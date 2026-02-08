impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn nums_same_consecutive_diff(n: i32, k: i32) -> Vec<i32> {
        let mut result = HashSet::new();
        for i in 1..10 {
            Self::dfs(i, n - 1, k, &mut result);
        }
        result.into_iter().collect()
    }

    fn dfs(mut current: i32, digits_left: i32, k: i32, result: &mut HashSet<i32>) {
        if digits_left == 0 {
            result.insert(current);
            return;
        }
        let last_digit = current % 10;
        if last_digit + k <= 9 {
            Self::dfs(current * 10 + (last_digit + k), digits_left - 1, k, result);
        }
        if last_digit - k >= 0 && k != 0 {
            Self::dfs(current * 10 + (last_digit - k), digits_left - 1, k, result);
        }
    }
}
}