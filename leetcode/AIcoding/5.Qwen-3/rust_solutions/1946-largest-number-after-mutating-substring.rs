impl Solution {

use std::cmp::Ordering;
use std::str;

impl Solution {
    pub fn largest_number(mut nums: Vec<i32>) -> String {
        let mut max_num = nums.clone();
        for i in 0..nums.len() {
            for j in i+1..nums.len() {
                let mut temp = nums.clone();
                temp[i] = temp[i].to_string().chars().rev().collect::<String>().parse::<i32>().unwrap();
                temp[j] = temp[j].to_string().chars().rev().collect::<String>().parse::<i32>().unwrap();
                if temp > max_num {
                    max_num = temp;
                }
            }
        }
        max_num.iter().map(|n| n.to_string()).collect()
    }
}
}