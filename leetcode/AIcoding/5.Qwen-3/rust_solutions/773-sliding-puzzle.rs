impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn sliding_puzzle(board: Vec<Vec<i32>>) -> i32 {
        let target = vec![1, 2, 3, 4, 5, 0];
        let start = board.into_iter().flatten().collect::<Vec<i32>>();

        let mut queue = VecDeque::new();
        queue.push_back((start, 0));
        let mut visited = HashSet::new();
        visited.insert(queue.front().unwrap().0.clone());

        let neighbors = [
            vec![1, 2],
            vec![0, 2, 3],
            vec![0, 1, 4],
            vec![1, 5],
            vec![2, 5],
            vec![3, 4],
        ];

        while let Some((current, steps)) = queue.pop_front() {
            if current == target {
                return steps;
            }

            let zero_index = current.iter().position(|&x| x == 0).unwrap();

            for &neighbor in &neighbors[zero_index] {
                let mut new_state = current.clone();
                new_state.swap(zero_index, neighbor);

                if !visited.contains(&new_state) {
                    visited.insert(new_state.clone());
                    queue.push_back((new_state, steps + 1));
                }
            }
        }

        -1
    }
}

struct Solution {}
}