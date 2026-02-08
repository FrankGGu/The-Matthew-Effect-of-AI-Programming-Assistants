struct Solution;

impl Solution {
    pub fn find_k_prime_factors(mut k: i32) -> i32 {
        let mut res = 0;
        while k > 0 {
            k /= 5;
            res += k;
        }
        res
    }

    pub fn preimage_size_f1231(k: i32) -> i32 {
        let mut left = 0;
        let mut right = 5 * k;
        while left < right {
            let mid = left + (right - left) / 2;
            let count = Solution::find_k_prime_factors(mid);
            if count < k {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        left
    }
}