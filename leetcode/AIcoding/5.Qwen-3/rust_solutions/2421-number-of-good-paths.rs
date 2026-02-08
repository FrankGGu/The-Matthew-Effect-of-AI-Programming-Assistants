impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn number_of_good_paths(parents: Vec<i32>, s: String) -> i32 {
        let n = s.len();
        let mut graph = vec![vec![]; n];
        for (i, &p) in parents.iter().enumerate() {
            if p != -1 {
                graph[p as usize].push(i);
            }
        }

        let mut value_to_nodes: HashMap<char, Vec<usize>> = HashMap::new();
        for (i, c) in s.chars().enumerate() {
            value_to_nodes.entry(c).or_insert_with(Vec::new).push(i);
        }

        let mut result = 0;
        let mut visited = vec![false; n];

        for (_, nodes) in value_to_nodes {
            let mut queue = VecDeque::new();
            for &node in &nodes {
                queue.push_back(node);
                visited[node] = true;
            }

            while let Some(current) = queue.pop_front() {
                for &neighbor in &graph[current] {
                    if !visited[neighbor] {
                        continue;
                    }
                    if s.chars().nth(current) == s.chars().nth(neighbor) {
                        queue.push_back(neighbor);
                    }
                }
            }

            result += nodes.len() as i32;
        }

        result
    }
}
}