impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn recover_rotated_subarray(mut encoded: Vec<i32>, mut first: i32) -> Vec<i32> {
        let n = encoded.len();
        let mut result = vec![first];
        for i in 0..n {
            first ^= encoded[i];
            result.push(first);
        }
        result
    }

    pub fn find_original_array(encoded: Vec<i32>, first: i32) -> Vec<i32> {
        let n = encoded.len();
        let mut result = vec![first];
        for i in 0..n {
            first ^= encoded[i];
            result.push(first);
        }
        result
    }
}
}