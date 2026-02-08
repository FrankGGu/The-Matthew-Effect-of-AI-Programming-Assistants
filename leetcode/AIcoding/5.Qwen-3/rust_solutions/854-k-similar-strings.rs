impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_k_solutions(s1: String, s2: String) -> i32 {
        if s1 == s2 {
            return 0;
        }

        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();

        queue.push_back((s1, 0));
        visited.insert(s1);

        while let Some((current, swaps)) = queue.pop_front() {
            for i in 0..current.len() {
                if current[i] != s2[i] {
                    for j in i + 1..current.len() {
                        if current[j] == s2[i] && current[i] == s2[j] {
                            let mut next = current.clone();
                            next.swap(i, j);
                            if next == s2 {
                                return swaps + 1;
                            }
                            if !visited.contains(&next) {
                                visited.insert(next.clone());
                                queue.push_back((next, swaps + 1));
                            }
                        }
                    }
                }
            }
        }

        -1
    }
}

struct Solution {}
}