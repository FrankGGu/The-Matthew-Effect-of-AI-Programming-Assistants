impl Solution {

use std::collections::HashMap;

struct NumberContainerSystem {
    index_map: HashMap<usize, i32>,
    value_map: HashMap<i32, Vec<usize>>,
}

impl NumberContainerSystem {
    fn new() -> Self {
        NumberContainerSystem {
            index_map: HashMap::new(),
            value_map: HashMap::new(),
        }
    }

    fn change(&mut self, index: usize, number: i32) {
        if let Some(&old_number) = self.index_map.get(&index) {
            if old_number == number {
                return;
            }
            if let Some(vec) = self.value_map.get_mut(&old_number) {
                vec.retain(|&i| i != index);
                if vec.is_empty() {
                    self.value_map.remove(&old_number);
                }
            }
        }
        self.index_map.insert(index, number);
        self.value_map.entry(number).or_insert_with(Vec::new).push(index);
    }

    fn find(&self, number: i32) -> usize {
        if let Some(vec) = self.value_map.get(&number) {
            *vec.first().unwrap()
        } else {
            panic!("No index found for the given number");
        }
    }

    fn get(&self, index: usize) -> i32 {
        *self.index_map.get(&index).unwrap()
    }
}
}