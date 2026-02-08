impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn frog_position_after_t_seconds(n: i32, edges: Vec<Vec<i32>>, t: i32, target: i32) -> i32 {
        let mut graph = HashMap::new();
        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            graph.entry(u).or_insert(Vec::new()).push(v);
            graph.entry(v).or_insert(Vec::new()).push(u);
        }

        let mut visited = vec![false; n as usize + 1];
        let mut queue = VecDeque::new();
        queue.push_back((1, 0, -1)); // (current node, time, parent)
        visited[1] = true;

        while let Some((node, time, parent)) = queue.pop_front() {
            if time == t {
                return if node == target { 1 } else { 0 };
            }

            let mut children = Vec::new();
            for &neighbor in graph.get(&node).unwrap_or(&vec![]) {
                if neighbor != parent {
                    children.push(neighbor);
                }
            }

            if children.is_empty() {
                if time < t {
                    return if node == target { 1 } else { 0 };
                }
            } else {
                for child in children {
                    if !visited[child as usize] {
                        visited[child as usize] = true;
                        queue.push_back((child, time + 1, node));
                    }
                }
            }
        }

        0
    }
}
}