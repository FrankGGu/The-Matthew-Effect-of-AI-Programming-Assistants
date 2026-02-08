impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn take_k_of_each_char(s: String, k: i32) -> i32 {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut left = 0;
        let mut right = s.len() as i32 - 1;
        let mut res = 0;

        while left <= right {
            let left_char = s.chars().nth(left as usize).unwrap();
            let right_char = s.chars().nth(right as usize).unwrap();

            if count[&left_char] > k && count[&right_char] > k {
                res += 1;
                count.entry(left_char).and_modify(|e| *e -= 1);
                count.entry(right_char).and_modify(|e| *e -= 1);
                left += 1;
                right -= 1;
            } else if count[&left_char] > k {
                res += 1;
                count.entry(left_char).and_modify(|e| *e -= 1);
                left += 1;
            } else if count[&right_char] > k {
                res += 1;
                count.entry(right_char).and_modify(|e| *e -= 1);
                right -= 1;
            } else {
                break;
            }
        }

        res
    }
}
}