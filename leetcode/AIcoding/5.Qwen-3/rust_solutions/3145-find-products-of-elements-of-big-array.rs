impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn get_products_of_elements(arr: Vec<i32>) -> Vec<i32> {
        let n = arr.len();
        let mut left = vec![1; n];
        let mut right = vec![1; n];

        for i in 1..n {
            left[i] = left[i - 1] * arr[i - 1];
        }

        for i in (0..n - 1).rev() {
            right[i] = right[i + 1] * arr[i + 1];
        }

        left.iter().zip(right.iter()).map(|(&l, &r)| l * r).collect()
    }
}
}