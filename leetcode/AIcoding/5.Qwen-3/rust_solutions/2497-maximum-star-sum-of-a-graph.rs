impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_star_sum(price: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            graph.entry(u).or_insert_with(Vec::new).push(v);
            graph.entry(v).or_insert_with(Vec::new).push(u);
        }

        let mut max_sum = 0;
        let mut visited = vec![false; price.len()];

        for i in 0..price.len() {
            if !visited[i] {
                let mut queue = std::collections::VecDeque::new();
                queue.push_back(i as i32);
                visited[i] = true;
                let mut sum = 0;
                while let Some(node) = queue.pop_front() {
                    sum += price[node as usize];
                    for &neighbor in graph.get(&node).unwrap_or(&vec![]) {
                        if !visited[neighbor as usize] {
                            visited[neighbor as usize] = true;
                            queue.push_back(neighbor);
                        }
                    }
                }
                max_sum = std::cmp::max(max_sum, sum);
            }
        }

        max_sum
    }
}
}