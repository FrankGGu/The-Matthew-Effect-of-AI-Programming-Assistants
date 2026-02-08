struct Solution;

impl Solution {
    pub fn my_sqrt(x: i32) -> i32 {
        if x < 2 {
            return x;
        }
        let mut left = 0;
        let mut right = x;
        while left <= right {
            let mid = left + (right - left) / 2;
            if mid * mid > x {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        right
    }
}