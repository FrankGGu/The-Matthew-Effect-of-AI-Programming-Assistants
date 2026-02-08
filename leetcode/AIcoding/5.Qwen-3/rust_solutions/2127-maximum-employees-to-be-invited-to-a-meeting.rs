impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn max_invitations(employees: Vec<Vec<i32>>) -> i32 {
        let n = employees.len();
        let mut graph = vec![vec![]; n];
        let mut in_degree = vec![0; n];

        for i in 0..n {
            let j = employees[i][0] as usize;
            graph[i].push(j);
            in_degree[j] += 1;
        }

        let mut visited = vec![false; n];
        let mut result = 0;

        for i in 0..n {
            if in_degree[i] == 0 {
                let mut queue = VecDeque::new();
                queue.push_back(i);
                visited[i] = true;

                while let Some(u) = queue.pop_front() {
                    for &v in &graph[u] {
                        in_degree[v] -= 1;
                        if in_degree[v] == 0 {
                            visited[v] = true;
                            queue.push_back(v);
                        }
                    }
                }
            }
        }

        for i in 0..n {
            if !visited[i] {
                let mut cycle_length = 0;
                let mut current = i;
                while !visited[current] {
                    visited[current] = true;
                    current = employees[current][0] as usize;
                    cycle_length += 1;
                }

                let mut chain_length = 0;
                for j in 0..n {
                    if employees[j][0] as usize == i && !visited[j] {
                        let mut temp = j;
                        let mut count = 0;
                        while !visited[temp] {
                            visited[temp] = true;
                            temp = employees[temp][0] as usize;
                            count += 1;
                        }
                        chain_length = std::cmp::max(chain_length, count);
                    }
                }

                result += cycle_length + chain_length;
            }
        }

        result as i32
    }
}
}