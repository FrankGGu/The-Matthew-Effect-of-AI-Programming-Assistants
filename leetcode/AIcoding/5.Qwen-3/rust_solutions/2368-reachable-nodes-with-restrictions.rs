impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn reachable_nodes(n: i32, edges: Vec<Vec<i32>>, restricted: Vec<i32>) -> i32 {
        let mut graph = vec![vec![]; n as usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut restricted_set: HashSet<usize> = restricted.into_iter().map(|x| x as usize).collect();
        let mut visited = vec![false; n as usize];
        let mut queue = VecDeque::new();
        let mut count = 0;

        for i in 0..n as usize {
            if !restricted_set.contains(&i) {
                queue.push_back(i);
                visited[i] = true;
                break;
            }
        }

        while let Some(node) = queue.pop_front() {
            count += 1;
            for &neighbor in &graph[node] {
                if !visited[neighbor] && !restricted_set.contains(&neighbor) {
                    visited[neighbor] = true;
                    queue.push_back(neighbor);
                }
            }
        }

        count
    }
}
}