impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn max_score(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut graph = vec![Vec::new(); n];
        for i in 0..n {
            for j in 0..n {
                if i != j && (nums[i] & nums[j]) == 0 {
                    graph[i].push(j);
                }
            }
        }

        let mut visited = vec![false; n];
        let mut result = 0;

        for i in 0..n {
            if !visited[i] {
                let mut queue = VecDeque::new();
                queue.push_back(i);
                visited[i] = true;
                let mut count = 0;
                while let Some(node) = queue.pop_front() {
                    count += 1;
                    for &neighbor in &graph[node] {
                        if !visited[neighbor] {
                            visited[neighbor] = true;
                            queue.push_back(neighbor);
                        }
                    }
                }
                result += count * nums[i];
            }
        }

        result
    }
}
}