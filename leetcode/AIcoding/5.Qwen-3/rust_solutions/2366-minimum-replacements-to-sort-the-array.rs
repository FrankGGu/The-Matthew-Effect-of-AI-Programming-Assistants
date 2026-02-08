impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_replacements(mut nums: Vec<i32>) -> i32 {
        let mut res = 0;
        let n = nums.len();

        for i in (0..n - 1).rev() {
            if nums[i] <= nums[i + 1] {
                continue;
            }

            let mut k = 1;
            let mut val = nums[i];

            while val % 2 == 0 && val / 2 > nums[i + 1] {
                val /= 2;
                k += 1;
            }

            while val % 2 != 0 && val / 2 >= nums[i + 1] {
                val = val / 2 + val % 2;
                k += 1;
            }

            res += k - 1;
            nums[i] = val;
        }

        res
    }
}
}