impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn is_possible_to_split(nums: Vec<i32>) -> bool {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut freq = HashMap::new();
        for &num in &nums {
            if *count.get(&num).unwrap() == 0 {
                continue;
            }
            if *freq.get(&(num - 1)).unwrap_or(&0) > 0 {
                *freq.entry(num - 1).or_insert(0) -= 1;
                *freq.entry(num).or_insert(0) += 1;
                *count.entry(num).or_insert(0) -= 1;
            } else {
                if *count.get(&(num + 1)).unwrap_or(&0) > 0 && *count.get(&(num + 2)).unwrap_or(&0) > 0 {
                    *count.entry(num).or_insert(0) -= 1;
                    *count.entry(num + 1).or_insert(0) -= 1;
                    *count.entry(num + 2).or_insert(0) -= 1;
                    *freq.entry(num + 2).or_insert(0) += 1;
                } else {
                    return false;
                }
            }
        }

        true
    }
}
}