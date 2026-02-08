impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_x_value(arr: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &num in &arr {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut max_freq = 0;
        let mut result = 0;

        for (&num, &freq) in &count {
            if freq > max_freq {
                max_freq = freq;
                result = num;
            } else if freq == max_freq {
                result = result.min(num);
            }
        }

        result
    }
}
}