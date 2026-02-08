impl Solution {

use std::cmp::min;

impl Solution {
    pub fn min_operations(mut nums: Vec<i32>) -> i32 {
        let mut operations = 0;
        let mut count = 0;

        for num in &nums {
            if *num == 1 {
                count += 1;
            }
        }

        if count == nums.len() {
            return 0;
        }

        for i in 0..nums.len() {
            if nums[i] != 1 {
                let gcd = Self::gcd(nums[i], 1);
                if gcd == 1 {
                    operations += 1;
                } else {
                    operations += 1;
                    nums[i] = 1;
                }
            }
        }

        operations + (nums.len() as i32 - count)
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}
}