impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn unequal_triplets(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut count = 0;
        let mut left = 0;
        let mut middle = 0;
        let mut right = 0;

        for (i, (&num, &freq_num)) in freq.iter().enumerate() {
            if i == 0 {
                left = freq_num;
            } else if i == 1 {
                middle = freq_num;
            } else {
                right = freq_num;
                count += left * middle * right;
                left = middle;
                middle = right;
            }
        }

        count as i32
    }
}
}