impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn plus_one(digits: Vec<i32>) -> Vec<i32> {
        let mut digits = digits;
        let mut carry = 1;
        for i in (0..digits.len()).rev() {
            let sum = digits[i] + carry;
            digits[i] = sum % 10;
            carry = sum / 10;
            if carry == 0 {
                break;
            }
        }
        if carry == 1 {
            digits.insert(0, 1);
        }
        digits
    }
}
}