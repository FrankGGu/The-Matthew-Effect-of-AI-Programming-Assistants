impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn intersection(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let mut count = HashMap::new();
        let mut result = vec![];

        for num in &nums[0] {
            *count.entry(*num).or_insert(0) += 1;
        }

        for i in 1..nums.len() {
            let mut temp = HashMap::new();
            for num in &nums[i] {
                if let Some(&c) = count.get(num) {
                    if c > 0 {
                        *temp.entry(*num).or_insert(0) += 1;
                    }
                }
            }
            count = temp;
        }

        for (key, _) in count {
            result.push(key);
        }

        result.sort();
        result
    }
}
}