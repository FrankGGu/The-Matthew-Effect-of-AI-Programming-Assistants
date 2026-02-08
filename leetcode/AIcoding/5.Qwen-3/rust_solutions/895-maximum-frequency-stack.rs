impl Solution {

use std::collections::{HashMap, VecDeque};

struct FreqStack {
    freq: HashMap<i32, i32>,
    groups: HashMap<i32, VecDeque<i32>>,
}

impl FreqStack {
    fn new() -> Self {
        FreqStack {
            freq: HashMap::new(),
            groups: HashMap::new(),
        }
    }

    fn push(&mut self, val: i32) {
        let count = self.freq.entry(val).or_insert(0);
        *count += 1;
        self.groups.entry(*count).or_insert(VecDeque::new()).push_back(val);
    }

    fn pop(&mut self) -> i32 {
        let max_freq = self.freq.values().max().copied().unwrap();
        let val = self.groups.get_mut(&max_freq).unwrap().pop_back().unwrap();
        *self.freq.get_mut(&val).unwrap() -= 1;
        if self.freq[&val] == 0 {
            self.freq.remove(&val);
        }
        if self.groups[&max_freq].is_empty() {
            self.groups.remove(&max_freq);
        }
        val
    }
}

struct Solution;

impl Solution {
    fn new() -> Self {
        Solution {}
    }

    fn push(&mut self, val: i32) {
        unimplemented!()
    }

    fn pop(&mut self) -> i32 {
        unimplemented!()
    }
}
}