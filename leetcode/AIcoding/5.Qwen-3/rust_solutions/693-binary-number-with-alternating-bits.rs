struct Solution {}

impl Solution {
    pub fn has_alternating_bits(n: i32) -> bool {
        let mut prev = n & 1;
        let mut n = n >> 1;
        while n > 0 {
            let current = n & 1;
            if current == prev {
                return false;
            }
            prev = current;
            n >>= 1;
        }
        true
    }
}