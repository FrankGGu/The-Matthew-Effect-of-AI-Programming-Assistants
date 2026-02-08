impl Solution {

use std::collections::HashMap;
use rand::Rng;

struct RandomizedSet {
    nums: Vec<i32>,
    index_map: HashMap<i32, usize>,
}

impl RandomizedSet {
    fn new() -> Self {
        RandomizedSet {
            nums: Vec::new(),
            index_map: HashMap::new(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        if self.index_map.contains_key(&val) {
            return false;
        }
        self.index_map.insert(val, self.nums.len());
        self.nums.push(val);
        true
    }

    fn remove(&mut self, val: i32) -> bool {
        if !self.index_map.contains_key(&val) {
            return false;
        }
        let index = self.index_map.remove(&val).unwrap();
        let last = *self.nums.last().unwrap();
        self.nums[index] = last;
        self.index_map.insert(last, index);
        self.nums.pop();
        true
    }

    fn get_random(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let index = rng.gen_range(0..self.nums.len());
        self.nums[index]
    }
}
}