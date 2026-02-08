impl Solution {

use std::collections::{HashMap, VecDeque};

struct RandomizedCollection {
    nums: Vec<i32>,
    index_map: HashMap<i32, VecDeque<usize>>,
}

impl RandomizedCollection {
    fn new() -> Self {
        RandomizedCollection {
            nums: Vec::new(),
            index_map: HashMap::new(),
        }
    }

    fn insert(&mut self, val: i32) -> bool {
        let index = self.nums.len();
        self.nums.push(val);
        let indices = self.index_map.entry(val).or_insert_with(VecDeque::new);
        indices.push_back(index);
        indices.len() == 1
    }

    fn remove(&mut self, val: i32) -> bool {
        if let Some(indices) = self.index_map.get_mut(&val) {
            let index = indices.pop_front().unwrap();
            let last_index = self.nums.len() - 1;
            if index != last_index {
                let last_val = self.nums[last_index];
                self.nums[index] = last_val;
                let last_indices = self.index_map.get_mut(&last_val).unwrap();
                last_indices.retain(|&i| i != last_index);
                last_indices.push_back(index);
            }
            self.nums.pop();
            if indices.is_empty() {
                self.index_map.remove(&val);
            }
            true
        } else {
            false
        }
    }

    fn get_random(&self) -> i32 {
        let index = rand::random::<usize>() % self.nums.len();
        self.nums[index]
    }
}
}