struct Solution {}

impl Solution {
    pub fn min_steps(n: i32) -> i32 {
        if n == 1 {
            return 0;
        }
        let mut res = 0;
        let mut i = 2;
        while i * i <= n {
            while n % i == 0 {
                res += i;
                n /= i;
            }
            i += 1;
        }
        if n > 1 {
            res += n;
        }
        res
    }
}