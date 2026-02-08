impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn max_fruits(basket: Vec<i32>, limit: i32) -> i32 {
        let mut count = HashMap::new();
        let mut left = 0;
        let mut max_fruits = 0;

        for right in 0..basket.len() {
            *count.entry(basket[right]).or_insert(0) += 1;

            while count.len() > 2 {
                *count.get_mut(&basket[left]).unwrap() -= 1;
                if *count.get_mut(&basket[left]).unwrap() == 0 {
                    count.remove(&basket[left]);
                }
                left += 1;
            }

            max_fruits = max_fruits.max((right - left + 1) as i32);
        }

        max_fruits
    }
}
}