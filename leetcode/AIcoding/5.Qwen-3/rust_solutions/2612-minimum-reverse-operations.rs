impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_reverse_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut graph = vec![vec![]; n];

        for i in 0..n {
            let left = i.saturating_sub(1);
            let right = i + 1;
            if left < n {
                graph[i].push(left);
                graph[left].push(i);
            }
            if right < n {
                graph[i].push(right);
                graph[right].push(i);
            }
        }

        let mut dist = vec![i32::MAX; n];
        let mut q = VecDeque::new();

        for i in 0..n {
            if nums[i] == 0 {
                dist[i] = 0;
                q.push_back(i);
            }
        }

        while let Some(u) = q.pop_front() {
            for &v in &graph[u] {
                if dist[v] == i32::MAX {
                    dist[v] = dist[u] + 1;
                    q.push_back(v);
                }
            }
        }

        for i in 0..n {
            if nums[i] == 0 {
                return dist[i];
            }
        }

        -1
    }
}
}