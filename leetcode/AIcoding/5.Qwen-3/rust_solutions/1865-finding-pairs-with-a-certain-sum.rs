impl Solution {

use std::collections::HashMap;

struct PairSum {
    nums: Vec<i32>,
    count: HashMap<i32, i32>,
}

impl PairSum {
    fn new(nums: Vec<i32>) -> Self {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }
        PairSum { nums, count }
    }

    fn add(&mut self, val: i32) {
        *self.count.entry(val).or_insert(0) += 1;
        self.nums.push(val);
    }

    fn count_pairs(&self, total: i32) -> i32 {
        let mut result = 0;
        for &num in &self.nums {
            let complement = total - num;
            if let Some(&cnt) = self.count.get(&complement) {
                result += cnt;
            }
        }
        result
    }
}

pub fn find_pairs(nums: Vec<i32>, k: i32) -> i32 {
    let mut pair_sum = PairSum::new(nums);
    let mut result = 0;
    for i in 0..pair_sum.nums.len() {
        let num = pair_sum.nums[i];
        let complement = k - num;
        if let Some(&cnt) = pair_sum.count.get(&complement) {
            result += cnt;
        }
        // Avoid counting the same pair twice
        if k == 0 {
            result -= 1; // subtract the current element itself
        }
    }
    result
}
}