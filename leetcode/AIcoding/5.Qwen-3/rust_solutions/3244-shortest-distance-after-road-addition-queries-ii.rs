impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn shortest_distance_after_road_additions(n: i32, queries: Vec<Vec<i32>>, roads: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut result = Vec::new();
        for query in queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
            result.push(bfs(&graph, n));
        }
        result
    }
}

fn bfs(graph: &Vec<Vec<usize>>, n: usize) -> i32 {
    let mut dist = vec![i32::MAX; n];
    dist[0] = 0;
    let mut queue = VecDeque::new();
    queue.push_back(0);

    while let Some(node) = queue.pop_front() {
        for &neighbor in &graph[node] {
            if dist[neighbor] > dist[node] + 1 {
                dist[neighbor] = dist[node] + 1;
                queue.push_back(neighbor);
            }
        }
    }

    dist[n - 1]
}
}