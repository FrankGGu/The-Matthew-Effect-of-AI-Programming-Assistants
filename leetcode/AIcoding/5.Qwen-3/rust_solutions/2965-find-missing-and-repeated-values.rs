impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn find_missing_and_repeated_value(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut seen = HashSet::new();
        let mut repeated = -1;
        let mut missing = -1;

        for row in nums {
            for num in row {
                if seen.contains(&num) {
                    repeated = num;
                } else {
                    seen.insert(num);
                }
            }
        }

        for i in 1..=n * n {
            if !seen.contains(&(i as i32)) {
                missing = i as i32;
                break;
            }
        }

        vec![missing, repeated]
    }
}
}