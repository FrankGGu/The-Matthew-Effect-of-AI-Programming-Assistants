impl Solution {

use std::collections::{HashMap, VecDeque};

struct Graph {
    adj: HashMap<i32, Vec<(i32, i32)>>,
}

impl Graph {
    fn new(n: i32, edges: Vec<Vec<i32>>) -> Self {
        let mut adj = HashMap::new();
        for i in 0..n {
            adj.insert(i, vec![]);
        }
        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            let w = edge[2];
            adj.get_mut(&u).unwrap().push((v, w));
            adj.get_mut(&v).unwrap().push((u, w));
        }
        Graph { adj }
    }

    fn add_edge(&mut self, edge: Vec<i32>) {
        let u = edge[0];
        let v = edge[1];
        let w = edge[2];
        self.adj.get_mut(&u).unwrap().push((v, w));
        self.adj.get_mut(&v).unwrap().push((u, w));
    }

    fn shortest_path(&self, node1: i32, node2: i32) -> i32 {
        let mut dist = HashMap::new();
        for &node in self.adj.keys() {
            dist.insert(node, i32::MAX);
        }
        dist.insert(node1, 0);
        let mut queue = VecDeque::new();
        queue.push_back(node1);

        while let Some(current) = queue.pop_front() {
            for &(neighbor, weight) in self.adj.get(&current).unwrap() {
                if *dist.get(&neighbor).unwrap() > *dist.get(&current).unwrap() + weight {
                    dist.insert(neighbor, *dist.get(&current).unwrap() + weight);
                    queue.push_back(neighbor);
                }
            }
        }

        *dist.get(&node2).unwrap()
    }
}

pub struct Solution;

impl Solution {
    pub fn create_graph(n: i32, edges: Vec<Vec<i32>>) -> Graph {
        Graph::new(n, edges)
    }

    pub fn add_edge(graph: &mut Graph, edge: Vec<i32>) {
        graph.add_edge(edge);
    }

    pub fn shortest_path(graph: &Graph, node1: i32, node2: i32) -> i32 {
        graph.shortest_path(node1, node2)
    }
}
}