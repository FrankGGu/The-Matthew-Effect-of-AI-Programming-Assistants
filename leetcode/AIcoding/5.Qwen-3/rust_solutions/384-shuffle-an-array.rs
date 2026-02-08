impl Solution {

use std::collections::HashSet;

struct Solution {
    original: Vec<i32>,
}

impl Solution {
    fn new(nums: Vec<i32>) -> Self {
        Solution { original: nums }
    }

    fn reset(&self) -> Vec<i32> {
        self.original.clone()
    }

    fn shuffle(&self) -> Vec<i32> {
        let mut rng = rand::thread_rng();
        let mut result = self.original.clone();
        result.shuffle(&mut rng);
        result
    }
}
}