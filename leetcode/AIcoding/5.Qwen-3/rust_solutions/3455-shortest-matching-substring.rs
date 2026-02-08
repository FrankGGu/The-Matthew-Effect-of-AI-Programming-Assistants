impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn shortest_substring(s: String) -> String {
        let mut result = s.clone();
        let n = s.len();

        for i in 0..n {
            for j in i + 1..n {
                let mut seen = HashSet::new();
                let mut queue = VecDeque::new();
                let mut visited = vec![false; n];

                let start = i;
                let end = j;
                queue.push_back((start, end));
                visited[start] = true;
                visited[end] = true;

                while let Some((u, v)) = queue.pop_front() {
                    if u == v {
                        let substring = &s[u..v + 1];
                        if substring.len() < result.len() {
                            result = substring.to_string();
                        }
                        continue;
                    }

                    for k in 0..n {
                        if !visited[k] && (s[k] == s[u] || s[k] == s[v]) {
                            visited[k] = true;
                            queue.push_back((k, v));
                            queue.push_back((u, k));
                        }
                    }
                }
            }
        }

        result
    }
}
}