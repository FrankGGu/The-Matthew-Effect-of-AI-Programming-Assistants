struct Solution;

impl Solution {
    pub fn split_num(n: i32, m: i32) -> i32 {
        let mut n = n;
        let mut m = m;
        let mut res = 0;
        while m > 0 {
            res += n % 10;
            n /= 10;
            m -= 1;
        }
        res
    }
}