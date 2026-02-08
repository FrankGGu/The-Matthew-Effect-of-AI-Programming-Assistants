impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_lucky(mut nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }
        nums.sort_unstable();
        for num in nums.into_iter().rev() {
            if let Some(&freq) = count.get(&num) {
                if freq == num {
                    return num;
                }
            }
        }
        -1
    }
}
}