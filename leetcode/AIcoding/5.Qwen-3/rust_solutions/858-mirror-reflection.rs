struct Solution {}

impl Solution {
    pub fn mirror_reflection(p: i32, q: i32) -> i32 {
        let mut m = p;
        let mut n = q;

        while m % n != 0 {
            let temp = m % n;
            m = n;
            n = temp;
        }

        let lcm = p * q / n;

        let a = lcm / p;
        let b = lcm / q;

        if a % 2 == 0 {
            return 2;
        } else if b % 2 == 0 {
            return 1;
        } else {
            return 0;
        }
    }
}