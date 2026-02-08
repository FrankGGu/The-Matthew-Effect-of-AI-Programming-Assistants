struct Solution;

impl Solution {
    pub fn binary_gap(n: i32) -> i32 {
        let mut max_gap = 0;
        let mut last_pos = -1;
        let mut n = n;
        let mut i = 0;
        while n > 0 {
            if n & 1 == 1 {
                if last_pos != -1 {
                    max_gap = std::cmp::max(max_gap, i - last_pos);
                }
                last_pos = i;
            }
            n >>= 1;
            i += 1;
        }
        max_gap
    }
}