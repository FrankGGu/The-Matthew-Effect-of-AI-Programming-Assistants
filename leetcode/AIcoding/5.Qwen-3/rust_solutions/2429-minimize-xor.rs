struct Solution {}

impl Solution {
    pub fn minimize_xor(mut num: i32) -> i32 {
        let mut result = 0;
        let mut mask = 1 << 30;
        while mask > 0 {
            let bit = (num & mask) != 0;
            if bit {
                result |= mask;
            }
            mask >>= 1;
        }
        result
    }
}