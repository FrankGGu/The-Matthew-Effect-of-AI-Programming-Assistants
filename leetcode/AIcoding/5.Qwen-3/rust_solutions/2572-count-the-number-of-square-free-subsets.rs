impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn square_free_subsets(nums: Vec<i32>) -> i32 {
        let mut dp = HashMap::new();
        dp.insert(0, 1);

        for &num in &nums {
            if num == 0 {
                continue;
            }
            let mut mask = 0;
            let mut n = num;
            let mut is_valid = true;
            for p in [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31].iter() {
                let mut cnt = 0;
                while n % p == 0 {
                    n /= p;
                    cnt += 1;
                }
                if cnt >= 2 {
                    is_valid = false;
                    break;
                }
                if cnt == 1 {
                    mask |= 1 << (*p as usize);
                }
            }
            if !is_valid || n > 1 {
                continue;
            }
            let mut new_dp = dp.clone();
            for (&key, &count) in &dp {
                if (key & mask) == 0 {
                    new_dp.insert(key | mask, (new_dp.get(&(key | mask)).unwrap_or(&0) + count) as i32);
                }
            }
            dp = new_dp;
        }

        let mut result = 0;
        for &count in dp.values() {
            result += count;
        }
        result
    }
}
}