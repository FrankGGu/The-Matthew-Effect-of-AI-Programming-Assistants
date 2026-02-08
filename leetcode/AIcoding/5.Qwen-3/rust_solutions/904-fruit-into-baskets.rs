impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn total_fruits(fruits: Vec<i32>) -> i32 {
        let mut basket = HashMap::new();
        let mut left = 0;
        let mut max_fruits = 0;

        for right in 0..fruits.len() {
            let fruit = fruits[right];
            *basket.entry(fruit).or_insert(0) += 1;

            while basket.len() > 2 {
                let left_fruit = fruits[left];
                *basket.get_mut(&left_fruit).unwrap() -= 1;
                if *basket.get_mut(&left_fruit).unwrap() == 0 {
                    basket.remove(&left_fruit);
                }
                left += 1;
            }

            max_fruits = max_fruits.max(right - left + 1);
        }

        max_fruits as i32
    }
}

pub struct Solution;
}