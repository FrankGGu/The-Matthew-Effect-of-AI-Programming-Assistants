impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        let mut operations = 0;
        let mut max = 0;

        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
            max = std::cmp::max(max, num);
        }

        let mut count = 0;
        for (num, &freq_num) in &freq {
            if freq_num > 1 {
                count += freq_num - 1;
            }
        }

        let required = (max as i32 + 1) - nums.len() as i32;
        if required > 0 {
            count += required;
        }

        count
    }
}
}