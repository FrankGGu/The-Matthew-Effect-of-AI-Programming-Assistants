impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_increments(mut nums: Vec<i32>, target: i32) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut res = 0;
        let mut current = 0;

        for (num, count) in freq {
            while current < target {
                if num > current {
                    res += (current - num + 1) * count;
                    current = num;
                } else {
                    res += (current - num + 1) * count;
                    current += 1;
                }
            }
        }

        res
    }
}
}