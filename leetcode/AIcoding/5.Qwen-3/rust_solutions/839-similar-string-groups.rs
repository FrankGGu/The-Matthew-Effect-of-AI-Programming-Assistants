impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn num_similar_groups(strs: Vec<String>) -> i32 {
        let n = strs.len();
        let mut visited = vec![false; n];
        let mut groups = 0;

        for i in 0..n {
            if !visited[i] {
                groups += 1;
                let mut queue = VecDeque::new();
                queue.push_back(i);
                visited[i] = true;

                while let Some(j) = queue.pop_front() {
                    for k in 0..n {
                        if !visited[k] && are_similar(&strs[j], &strs[k]) {
                            visited[k] = true;
                            queue.push_back(k);
                        }
                    }
                }
            }
        }

        groups
    }
}

fn are_similar(s1: &str, s2: &str) -> bool {
    if s1 == s2 {
        return true;
    }

    let mut diff = 0;
    for (c1, c2) in s1.chars().zip(s2.chars()) {
        if c1 != c2 {
            diff += 1;
            if diff > 2 {
                return false;
            }
        }
    }

    diff == 2
}
}