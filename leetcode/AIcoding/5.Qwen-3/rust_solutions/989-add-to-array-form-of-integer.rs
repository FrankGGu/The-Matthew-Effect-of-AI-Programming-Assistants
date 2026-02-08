impl Solution {

use std::vec;

impl Solution {
    pub fn add_to_array_form(num: Vec<i32>, k: i32) -> Vec<i32> {
        let mut num = num;
        let mut k = k;
        let mut i = num.len() as i32 - 1;

        while k > 0 {
            if i >= 0 {
                let sum = num[i as usize] + k % 10;
                num[i as usize] = sum % 10;
                k = sum / 10;
            } else {
                num.insert(0, k % 10);
            }
            k /= 10;
            i -= 1;
        }

        num
    }
}
}