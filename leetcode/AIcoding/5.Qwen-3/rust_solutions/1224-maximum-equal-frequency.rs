impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn max_equal_frequency(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        let mut count = HashMap::new();
        let mut max_freq = 0;

        for &num in &nums {
            let cnt = freq.entry(num).or_insert(0);
            *cnt += 1;
            max_freq = std::cmp::max(max_freq, *cnt);
            *count.entry(*cnt).or_insert(0) += 1;
            *count.entry(*cnt - 1).or_insert(0) -= 1;
        }

        if max_freq == 1 || count.len() == 1 {
            return nums.len() as i32;
        }

        for &num in &nums {
            let cnt = *freq.get(&num).unwrap();
            *count.entry(cnt).or_insert(0) -= 1;
            if count[&cnt] == 0 {
                count.remove(&cnt);
            }
            *count.entry(cnt - 1).or_insert(0) += 1;
            if count.len() == 1 {
                return nums.len() as i32;
            }
            *count.entry(cnt - 1).or_insert(0) -= 1;
            if count[&cnt - 1] == 0 {
                count.remove(&cnt - 1);
            }
            *count.entry(cnt).or_insert(0) += 1;
        }

        0
    }
}
}