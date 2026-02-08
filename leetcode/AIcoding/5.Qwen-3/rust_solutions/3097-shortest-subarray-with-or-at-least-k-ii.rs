impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn minimum_subarray_length(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut min_len = n as i32 + 1;
        let mut bit_count = vec![0; 32];

        let mut left = 0;
        let mut right = 0;

        while right < n {
            let num = nums[right];
            for i in 0..32 {
                if (num >> i) & 1 == 1 {
                    bit_count[i] += 1;
                }
            }

            while self::is_valid(&bit_count, k) {
                min_len = std::cmp::min(min_len, (right - left + 1) as i32);

                let left_num = nums[left];
                for i in 0..32 {
                    if (left_num >> i) & 1 == 1 {
                        bit_count[i] -= 1;
                    }
                }
                left += 1;
            }

            right += 1;
        }

        if min_len > n as i32 {
            -1
        } else {
            min_len
        }
    }

    fn is_valid(bit_count: &[i32], k: i32) -> bool {
        for i in 0..32 {
            if bit_count[i] > 0 && (1 << i) >= k {
                return true;
            }
        }
        false
    }
}
}