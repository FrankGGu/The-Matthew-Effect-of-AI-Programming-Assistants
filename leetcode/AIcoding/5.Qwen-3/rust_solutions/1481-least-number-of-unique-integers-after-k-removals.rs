impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_least_num_of_unique_ints(arr: Vec<i32>, k: i32) -> i32 {
        let mut freq = HashMap::new();
        for &num in &arr {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut counts: Vec<_> = freq.values().cloned().collect();
        counts.sort();

        let mut remaining = k;
        for count in counts {
            if remaining >= count {
                remaining -= count;
            } else {
                return (freq.len() as i32) - (counts.iter().position(|&c| c == count).unwrap() as i32);
            }
        }

        (freq.len() as i32) - (counts.len() as i32)
    }
}
}