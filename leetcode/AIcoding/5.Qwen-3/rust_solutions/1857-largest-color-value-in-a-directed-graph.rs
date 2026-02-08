impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn largest_color_value(adj: Vec<Vec<i32>>, colors: Vec<i32>) -> i32 {
        let n = adj.len();
        let mut in_degree = vec![0; n];
        let mut graph = vec![vec![]; n];

        for (i, neighbors) in adj.iter().enumerate() {
            for &neighbor in neighbors {
                graph[i].push(neighbor as usize);
                in_degree[neighbor as usize] += 1;
            }
        }

        let mut queue = VecDeque::new();
        for i in 0..n {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut color_count = vec![vec![0; 256]; n];
        let mut max_color = 0;

        while let Some(node) = queue.pop_front() {
            let color = colors[node] as usize;
            color_count[node][color] += 1;
            max_color = max_color.max(color_count[node][color]);

            for &neighbor in &graph[node] {
                in_degree[neighbor] -= 1;
                if in_degree[neighbor] == 0 {
                    queue.push_back(neighbor);
                }

                for i in 0..256 {
                    color_count[neighbor][i] = color_count[neighbor][i].max(color_count[node][i]);
                }
            }
        }

        max_color
    }
}
}