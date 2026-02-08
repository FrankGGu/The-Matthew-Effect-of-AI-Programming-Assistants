impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn relocate_marbles(mut nums: Vec<i32>, mut move_from: Vec<i32>, mut move_to: Vec<i32>) -> Vec<i32> {
        let mut set = HashSet::new();
        for num in &nums {
            set.insert(*num);
        }

        for i in 0..move_from.len() {
            let from = move_from[i];
            let to = move_to[i];
            if set.contains(&from) {
                set.remove(&from);
                set.insert(to);
            }
        }

        let mut result: Vec<i32> = set.into_iter().collect();
        result.sort();
        result
    }
}
}