impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn triangle_type(mut a: i32, mut b: i32, mut c: i32) -> String {
        if a > b {
            a.swap(&mut b);
        }
        if b > c {
            b.swap(&mut c);
        }
        if a > b {
            a.swap(&mut b);
        }

        if a + b <= c {
            "invalid".to_string()
        } else if a == b && b == c {
            "equilateral".to_string()
        } else if a == b || b == c || a == c {
            "isosceles".to_string()
        } else {
            "scalene".to_string()
        }
    }
}
}