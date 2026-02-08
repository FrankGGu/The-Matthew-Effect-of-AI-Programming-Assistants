impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_kpairs(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut pairs = 0;
        for &num in &nums {
            let complement = k - num;
            if let Some(&mut c) = count.get_mut(&complement) {
                if num == complement {
                    if c >= 2 {
                        pairs += 1;
                        *c -= 2;
                    }
                } else {
                    if c > 0 {
                        pairs += 1;
                        *c -= 1;
                    }
                }
            }
        }

        pairs
    }
}
}