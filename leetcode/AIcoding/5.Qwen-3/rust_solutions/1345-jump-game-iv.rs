impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_jumps(arr: Vec<i32>, start: i32) -> i32 {
        let n = arr.len();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        let mut steps = 0;

        queue.push_back(start as usize);
        visited.insert(start as usize);

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let current = queue.pop_front().unwrap();
                if current == 0 {
                    return steps;
                }
                let val = arr[current];
                for neighbor in [current as i32 - 1, current as i32 + 1] {
                    if neighbor >= 0 && neighbor < n as i32 && !visited.contains(&(neighbor as usize)) {
                        visited.insert(neighbor as usize);
                        queue.push_back(neighbor as usize);
                    }
                }
                for i in 0..n {
                    if arr[i] == val && i != current && !visited.contains(&i) {
                        visited.insert(i);
                        queue.push_back(i);
                    }
                }
            }
            steps += 1;
        }

        -1
    }
}

pub struct Solution;
}