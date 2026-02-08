struct Solution {}

impl Solution {
    pub fn arrange_coins(n: i32) -> i32 {
        let mut n = n as i64;
        let mut left = 1;
        let mut right = n;
        let mut ans = 0;
        while left <= right {
            let mid = left + (right - left) / 2;
            let total = mid * (mid + 1) / 2;
            if total <= n {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        ans as i32
    }
}