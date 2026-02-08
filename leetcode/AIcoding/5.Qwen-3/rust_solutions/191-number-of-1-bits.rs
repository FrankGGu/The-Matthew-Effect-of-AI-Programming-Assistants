struct Solution;

impl Solution {
    pub fn hamming_weight(mut n: u32) -> i32 {
        let mut count = 0;
        while n > 0 {
            count += n & 1;
            n >>= 1;
        }
        count
    }
}