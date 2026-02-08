impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_k_reducible_numbers(n: i32, k: i32) -> i32 {
        let mut seen = HashSet::new();
        let mut result = 0;
        for num in 1..=n {
            let mut current = num;
            let mut is_k_reducible = true;
            while current > 0 {
                if current % k == 0 {
                    current /= k;
                } else {
                    is_k_reducible = false;
                    break;
                }
            }
            if is_k_reducible {
                result += 1;
            }
        }
        result
    }
}
}