impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn count_valid_paths(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        if n == 1 {
            return 1;
        }

        let mut graph = HashMap::new();
        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            graph.entry(u).or_insert(vec![]);
            graph.entry(v).or_insert(vec![]);
            graph.get_mut(&u).unwrap().push(v);
            graph.get_mut(&v).unwrap().push(u);
        }

        let mut result = 0;

        for &start in graph.keys() {
            let mut visited = vec![false; n as usize];
            let mut queue = VecDeque::new();
            queue.push_back((start, -1, 0));
            visited[start as usize] = true;

            while let Some((node, parent, depth)) = queue.pop_front() {
                if depth >= 2 {
                    result += 1;
                    continue;
                }

                for &neighbor in graph.get(&node).unwrap() {
                    if neighbor != parent {
                        visited[neighbor as usize] = true;
                        queue.push_back((neighbor, node, depth + 1));
                    }
                }
            }
        }

        result
    }
}
}