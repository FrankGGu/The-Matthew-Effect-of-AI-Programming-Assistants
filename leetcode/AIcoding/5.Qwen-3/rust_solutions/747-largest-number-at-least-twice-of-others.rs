impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn dominant_index(nums: Vec<i32>) -> i32 {
        let mut max1 = -1;
        let mut max2 = -1;
        let mut index = -1;

        for (i, &num) in nums.iter().enumerate() {
            match num.cmp(&max1) {
                Ordering::Greater => {
                    max2 = max1;
                    max1 = num;
                    index = i as i32;
                }
                _ if num > max2 => {
                    max2 = num;
                }
                _ => {}
            }
        }

        if max1 >= max2 * 2 {
            index
        } else {
            -1
        }
    }
}
}