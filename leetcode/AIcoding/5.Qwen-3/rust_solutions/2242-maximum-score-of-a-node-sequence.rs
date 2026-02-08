impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn maximum_score(scores: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = scores.len();
        let mut graph = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        for i in 0..n {
            graph[i].sort_by(|&a, &b| scores[b].cmp(&scores[a]));
        }

        let mut result = i32::MIN;

        for i in 0..n {
            let mut candidates = HashSet::new();
            for &j in &graph[i] {
                if candidates.len() >= 2 {
                    break;
                }
                candidates.insert(j);
            }

            for &j in &graph[i] {
                if candidates.contains(&j) {
                    continue;
                }
                for &k in &graph[j] {
                    if k == i {
                        continue;
                    }
                    if candidates.contains(&k) {
                        continue;
                    }
                    let score = scores[i] + scores[j] + scores[k];
                    result = result.max(score);
                }
            }
        }

        result
    }
}
}