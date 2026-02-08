struct Solution {}

impl Solution {
    pub fn kth_symbol(n: i32, k: i32) -> i32 {
        fn helper(n: i32, k: i32) -> i32 {
            if n == 1 {
                return 0;
            }
            let half = 1 << (n - 2);
            if k <= half {
                helper(n - 1, k)
            } else {
                1 - helper(n - 1, k - half)
            }
        }
        helper(n, k)
    }
}