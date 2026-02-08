struct Solution {}

impl Solution {
    pub fn count_bits(n: i32) -> Vec<i32> {
        let mut result = vec![0; n as usize];
        for i in 1..n as usize {
            result[i] = result[i >> 1] + (i & 1) as i32;
        }
        result
    }
}