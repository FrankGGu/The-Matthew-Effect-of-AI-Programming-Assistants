impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn max_number_of_groups(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut res = 0;
        let mut prev = 0;

        for (num, count) in freq.iter_mut().sorted_by(|a, b| a.0.cmp(b.0)) {
            if *num > prev + 1 {
                break;
            }
            let take = (*count).min(prev + 1 - *num);
            res += take;
            prev = *num + take;
        }

        res
    }
}
}