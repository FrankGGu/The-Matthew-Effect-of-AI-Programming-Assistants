impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn number_of_ways(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for e in edges {
            let u = e[0] as usize;
            let v = e[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = vec![false; n];
        let mut color = vec![0; n];
        let mut components = vec![];
        let mut component_id = 0;

        for i in 0..n {
            if !visited[i] {
                let mut stack = vec![i];
                visited[i] = true;
                let mut component = vec![];
                while let Some(node) = stack.pop() {
                    component.push(node);
                    for &neigh in &graph[node] {
                        if !visited[neigh] {
                            visited[neigh] = true;
                            stack.push(neigh);
                        }
                    }
                }
                components.push(component);
                component_id += 1;
            }
        }

        let mut degree = vec![0; n];
        for e in edges {
            let u = e[0] as usize;
            let v = e[1] as usize;
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut root = -1;
        for i in 0..n {
            if degree[i] == 1 {
                root = i as i32;
                break;
            }
        }

        if root == -1 {
            return 0;
        }

        let mut parent = vec![-1; n];
        let mut depth = vec![0; n];
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(root as usize);
        visited = vec![false; n];
        visited[root as usize] = true;

        while let Some(u) = queue.pop_front() {
            for &v in &graph[u] {
                if !visited[v] {
                    visited[v] = true;
                    parent[v] = u as i32;
                    depth[v] = depth[u] + 1;
                    queue.push_back(v);
                }
            }
        }

        let mut max_depth = 0;
        for d in &depth {
            max_depth = std::cmp::max(max_depth, *d);
        }

        let mut count = 1;
        for i in 0..components.len() {
            let size = components[i].len();
            if size > 1 {
                count *= (size as i32 - 1);
            }
        }

        count
    }
}
}