struct Solution;

impl Solution {
    pub fn is_reachable(x: i32, y: i32) -> bool {
        let mut x = x;
        let mut y = y;
        while x > 0 && y > 0 {
            if x < y {
                std::mem::swap(&mut x, &mut y);
            }
            if y == 0 {
                return true;
            }
            x %= y;
        }
        x == 1 || y == 1
    }
}