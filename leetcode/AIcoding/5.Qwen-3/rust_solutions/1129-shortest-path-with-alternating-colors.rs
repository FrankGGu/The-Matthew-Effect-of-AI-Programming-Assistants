impl Solution {

use std::collections::{VecDeque, HashMap};

fn shortest_path_with_alternating_colors() {
    fn bfs(colors: Vec<i32>, red_edges: Vec<Vec<i32>>, blue_edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = colors.len();
        let mut graph = HashMap::new();
        graph.insert(0, vec![]);
        graph.insert(1, vec![]);

        for edge in red_edges {
            graph.get_mut(&0).unwrap().push(edge[1] as usize);
        }

        for edge in blue_edges {
            graph.get_mut(&1).unwrap().push(edge[1] as usize);
        }

        let mut dist = vec![i32::MAX; n];
        dist[0] = 0;

        let mut queue = VecDeque::new();
        queue.push_back((0, 0, 0)); // (node, color, distance)

        while let Some((node, color, d)) = queue.pop_front() {
            for &next_node in graph.get(&(1 - color)).unwrap() {
                if dist[next_node] > d + 1 {
                    dist[next_node] = d + 1;
                    queue.push_back((next_node, 1 - color, d + 1));
                }
            }
        }

        dist
    }

    fn solve(n: i32, red_edges: Vec<Vec<i32>>, blue_edges: Vec<Vec<i32>>) -> Vec<i32> {
        let colors = vec![0; n as usize];
        bfs(colors, red_edges, blue_edges)
    }

    fn main() {
        let n = 3;
        let red_edges = vec![vec![0,1], vec![1,2]];
        let blue_edges = vec![vec![1,2]];
        let result = solve(n, red_edges, blue_edges);
        println!("{:?}", result);
    }
}
}