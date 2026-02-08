impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn max_xor_product(mut a: i64, mut b: i64) -> i64 {
        let mut x = a;
        let mut y = b;
        for i in 0..60 {
            let bit = 1_i64 << (60 - i);
            let mask = bit - 1;
            let xa = x ^ bit;
            let xb = x & bit;
            let ya = y ^ bit;
            let yb = y & bit;
            let mut val_xa = xa & mask;
            let mut val_ya = ya & mask;
            let mut val_xb = xb;
            let mut val_yb = yb;
            if val_xa > val_xb {
                val_xb = val_xa;
                val_yb = val_ya;
            }
            if val_xb > val_xa {
                val_xa = val_xb;
                val_ya = val_yb;
            }
            if val_xa * val_ya > val_xb * val_yb {
                x = xa;
                y = ya;
            } else {
                x = xb;
                y = yb;
            }
        }
        return x * y;
    }
}
}