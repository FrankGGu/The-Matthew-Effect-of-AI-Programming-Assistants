struct Solution;

impl Solution {
    pub fn eliminate_players(n: i32) -> i32 {
        let mut left = true;
        let mut remaining = n;
        let mut step = 1;

        while remaining > 1 {
            if left || remaining % 2 == 0 {
                remaining /= 2;
            } else {
                remaining = (remaining - 1) / 2;
            }
            step *= 2;
            left = !left;
        }

        step
    }
}