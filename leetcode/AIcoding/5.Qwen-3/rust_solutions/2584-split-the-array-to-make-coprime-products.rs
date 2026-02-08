impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn is_coprime_subarrays(nums: Vec<i32>) -> bool {
        fn gcd(a: i32, b: i32) -> i32 {
            if b == 0 {
                a
            } else {
                gcd(b, a % b)
            }
        }

        let n = nums.len();
        for i in 0..n {
            let mut product = 1;
            for j in i..n {
                product *= nums[j];
                let mut coprime = true;
                for k in 0..i {
                    if gcd(product, nums[k]) != 1 {
                        coprime = false;
                        break;
                    }
                }
                if coprime {
                    return true;
                }
            }
        }
        false
    }
}
}