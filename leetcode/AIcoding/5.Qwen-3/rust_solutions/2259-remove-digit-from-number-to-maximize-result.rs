impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn remove_digit(mut num: String, digit: char) -> String {
        let mut index = -1;
        for i in 0..num.len() {
            if num.chars().nth(i).unwrap() == digit {
                index = i as i32;
                if i + 1 < num.len() && num.chars().nth(i + 1).unwrap() > digit {
                    break;
                }
            }
        }
        num.remove(index as usize);
        num
    }
}
}