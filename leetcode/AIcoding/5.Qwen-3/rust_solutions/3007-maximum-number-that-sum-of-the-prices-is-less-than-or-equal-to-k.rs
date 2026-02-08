struct Solution;

impl Solution {
    pub fn max_number(k: i64) -> i64 {
        let mut res = 0;
        let mut price = 0;
        let mut i = 1;
        while price <= k {
            let mut num = i;
            let mut p = 0;
            while num > 0 {
                p += 1;
                num /= 10;
            }
            price += p;
            if price > k {
                break;
            }
            res = i;
            i += 1;
        }
        res
    }
}