struct Solution;

impl Solution {
    pub fn xor_operation(mut n: i32, mut start: i32) -> i32 {
        let mut result = 0;
        for i in 0..n {
            result ^= start + 2 * i;
        }
        result
    }
}