impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn sum_imbalance_numbers(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut result = 0;
        for i in 0..n {
            let mut set = BTreeSet::new();
            set.insert(nums[i]);
            for j in i + 1..n {
                set.insert(nums[j]);
                let mut imbalance = 0;
                let mut prev = *set.iter().next().unwrap();
                for &num in set.iter().skip(1) {
                    if num - prev > 1 {
                        imbalance += num - prev - 1;
                    }
                    prev = num;
                }
                result += imbalance;
            }
        }
        result
    }
}
}