impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn min_operations(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();
        nums.sort();
        let unique_nums: BTreeSet<i32> = nums.iter().cloned().collect();
        let mut min_ops = n as i32;

        for (i, &num) in unique_nums.iter().enumerate() {
            let mut j = i;
            while j < unique_nums.len() && unique_nums.iter().nth(j).unwrap() - num <= n as i32 - 1 {
                j += 1;
            }
            let count = j - i;
            min_ops = min_ops.min(n as i32 - count);
        }

        min_ops
    }
}
}