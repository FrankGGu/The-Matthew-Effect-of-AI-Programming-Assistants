impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn num_must_have(n: i32, m: i32, a: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &num in &a {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut result = 0;
        for (_, &freq) in &count {
            if freq >= m {
                result += 1;
            }
        }

        result
    }
}
}