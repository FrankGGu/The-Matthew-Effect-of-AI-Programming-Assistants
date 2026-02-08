struct Solution {}

impl Solution {
    pub fn broken_calc(x: i32, y: i32) -> i32 {
        let mut res = 0;
        let mut y = y;
        while x < y {
            y += 1;
            y /= 2;
            res += 1;
        }
        res + x - y
    }
}