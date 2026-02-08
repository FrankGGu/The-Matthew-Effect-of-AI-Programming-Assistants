impl Solution {

use std::cmp::Ordering;
use std::string::String;

impl Solution {
    pub fn largest_number(nums: Vec<i32>) -> String {
        let mut nums_str: Vec<String> = nums.into_iter().map(|n| n.to_string()).collect();

        nums_str.sort_by(|a, b| {
            let ab = format!("{}{}", a, b);
            let ba = format!("{}{}", b, a);
            ba.cmp(&ab)
        });

        if nums_str[0] == "0" {
            return "0".to_string();
        }

        nums_str.join("")
    }
}

pub struct Solution;
}