impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_distinct_numbers(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = HashMap::new();
        for num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut counts = freq.values().cloned().collect::<Vec<_>>();
        counts.sort();

        let mut res = 0;
        for count in counts {
            if count <= k {
                k -= count;
                res += 1;
            } else {
                res += 1;
                k -= 1;
                if k == 0 {
                    break;
                }
            }
        }

        res
    }
}
}