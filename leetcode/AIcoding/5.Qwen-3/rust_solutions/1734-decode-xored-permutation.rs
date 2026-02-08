impl Solution {

use std::vec::Vec;

impl Solution {
    pub fn find_xor_permutation(n: i32, start: i32, xor_array: Vec<i32>) -> Vec<i32> {
        let n = n as usize;
        let mut xor = 0;
        for i in 0..n {
            xor ^= (start + i as i32) ^ xor_array[i];
        }
        let mut res = vec![0; n];
        res[0] = xor ^ start;
        for i in 1..n {
            res[i] = res[i - 1] ^ xor_array[i - 1];
        }
        res
    }
}

struct Solution;
}