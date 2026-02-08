impl Solution {

use std::collections::{HashMap, HashSet};

struct AllOne {
    buckets: HashMap<i32, HashSet<String>>,
    key_count: HashMap<String, i32>,
    max: i32,
    min: i32,
}

impl AllOne {
    fn new() -> Self {
        AllOne {
            buckets: HashMap::new(),
            key_count: HashMap::new(),
            max: 0,
            min: 0,
        }
    }

    fn inc(&mut self, key: String) {
        let count = *self.key_count.get(&key).unwrap_or(&0);
        if count > 0 {
            self.buckets.get_mut(&count).unwrap().remove(&key);
            if self.buckets.get(&count).unwrap().is_empty() {
                self.buckets.remove(&count);
            }
        }

        let new_count = count + 1;
        self.key_count.insert(key.clone(), new_count);

        self.buckets.entry(new_count).or_insert_with(HashSet::new).insert(key);

        if self.max < new_count {
            self.max = new_count;
        }

        if self.min == 0 || self.min > count {
            self.min = count;
        }
    }

    fn dec(&mut self, key: String) {
        let count = *self.key_count.get(&key).unwrap();
        self.buckets.get_mut(&count).unwrap().remove(&key);
        if self.buckets.get(&count).unwrap().is_empty() {
            self.buckets.remove(&count);
        }

        let new_count = count - 1;
        if new_count > 0 {
            self.key_count.insert(key.clone(), new_count);
            self.buckets.entry(new_count).or_insert_with(HashSet::new).insert(key);
        } else {
            self.key_count.remove(&key);
        }

        if self.min == count && self.buckets.get(&count).unwrap().is_empty() {
            self.buckets.remove(&count);
            self.min = self.buckets.keys().next().copied().unwrap_or(0);
        }
    }

    fn get_max_key(&self) -> String {
        let mut keys = self.buckets.get(&self.max).unwrap().clone();
        keys.into_iter().next().unwrap()
    }

    fn get_min_key(&self) -> String {
        let mut keys = self.buckets.get(&self.min).unwrap().clone();
        keys.into_iter().next().unwrap()
    }
}
}