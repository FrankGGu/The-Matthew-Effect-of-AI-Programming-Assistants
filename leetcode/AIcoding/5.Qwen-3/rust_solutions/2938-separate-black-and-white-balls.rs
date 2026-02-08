struct Solution;

impl Solution {
    pub fn count_black_and_white_balls(black: i32, white: i32) -> i32 {
        let mut result = 0;
        let mut b = black;
        let mut w = white;

        while b > 0 && w > 0 {
            if b > w {
                result += w;
                b -= w;
            } else {
                result += b;
                w -= b;
            }
        }

        result
    }
}