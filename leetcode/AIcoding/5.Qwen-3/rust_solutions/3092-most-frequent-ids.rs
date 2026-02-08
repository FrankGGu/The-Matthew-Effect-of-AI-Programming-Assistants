impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn most_frequent_ids(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut freq = HashMap::new();
        let mut max_freq = 0;
        let mut result = Vec::new();

        for num in nums {
            *freq.entry(num).or_insert(0) += 1;
            if *freq.get(&num).unwrap() > max_freq {
                max_freq = *freq.get(&num).unwrap();
            }
            if (result.len() as i32) < k {
                result.push(max_freq);
            } else {
                break;
            }
        }

        result
    }
}
}