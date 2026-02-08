impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_2d_array(mut nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        while !freq.is_empty() {
            let mut row = Vec::new();
            let mut to_remove = Vec::new();
            for (&num, &count) in &freq {
                if count > 0 {
                    row.push(num);
                    *freq.get_mut(&num).unwrap() -= 1;
                    if *freq.get_mut(&num).unwrap() == 0 {
                        to_remove.push(num);
                    }
                }
            }
            for num in to_remove {
                freq.remove(&num);
            }
            result.push(row);
        }

        result
    }
}
}