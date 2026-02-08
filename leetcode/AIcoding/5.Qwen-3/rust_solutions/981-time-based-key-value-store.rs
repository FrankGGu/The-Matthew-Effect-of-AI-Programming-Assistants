impl Solution {

use std::collections::HashMap;
use std::cmp::Ordering;

struct TimeMap {
    data: HashMap<String, Vec<(i32, String)>>,
}

impl TimeMap {
    fn new() -> Self {
        TimeMap {
            data: HashMap::new(),
        }
    }

    fn set(&mut self, key: String, value: String, timestamp: i32) {
        self.data.entry(key).or_insert_with(Vec::new).push((timestamp, value));
    }

    fn get(&self, key: String, timestamp: i32) -> String {
        match self.data.get(&key) {
            Some(vec) => {
                let mut left = 0;
                let mut right = vec.len() - 1;
                let mut result = String::new();
                while left <= right {
                    let mid = left + (right - left) / 2;
                    match vec[mid].0.cmp(&timestamp) {
                        Ordering::Less => {
                            result = vec[mid].1.clone();
                            left = mid + 1;
                        }
                        Ordering::Equal => {
                            return vec[mid].1.clone();
                        }
                        Ordering::Greater => {
                            right = mid - 1;
                        }
                    }
                }
                result
            }
            None => String::new(),
        }
    }
}
}