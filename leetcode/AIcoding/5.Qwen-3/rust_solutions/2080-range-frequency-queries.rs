impl Solution {

use std::collections::HashMap;

struct RangeFreqQuery {
    freq: HashMap<usize, Vec<usize>>,
}

impl RangeFreqQuery {
    fn new(arr: Vec<i32>) -> Self {
        let mut freq = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            freq.entry(num as usize).or_insert_with(Vec::new).push(i);
        }
        RangeFreqQuery { freq }
    }

    fn query(&self, left: i32, right: i32, value: i32) -> i32 {
        let key = value as usize;
        if let Some(indices) = self.freq.get(&key) {
            let left = left as usize;
            let right = right as usize;
            let l = indices.binary_search(&left).unwrap_or_else(|x| x);
            let r = indices.binary_search(&(right + 1)).unwrap_or_else(|x| x);
            (r - l) as i32
        } else {
            0
        }
    }
}

pub fn solve() {
    // This is a placeholder to make the module compilable.
    // LeetCode expects a function with specific signature.
    // The actual solution should be implemented in the `main` function or via the provided class.
}
}