struct Solution;

impl Solution {
    pub fn min_swaps_ascii(s1: String, s2: String) -> i32 {
        let mut a = 0;
        let mut b = 0;
        for (c1, c2) in s1.chars().zip(s2.chars()) {
            if c1 != c2 {
                if c1 == 'a' {
                    a += 1;
                } else {
                    b += 1;
                }
            }
        }
        if (a + b) % 2 != 0 {
            return -1;
        }
        (a / 2 + b / 2 + (a % 2) * 2) as i32
    }
}