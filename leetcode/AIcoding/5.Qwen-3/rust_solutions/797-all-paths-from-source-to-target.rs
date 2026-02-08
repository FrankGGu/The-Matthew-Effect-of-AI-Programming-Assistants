impl Solution {

use std::collections::VecDeque;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub neighbors: Vec<Node>,
}

pub fn node(val: i32) -> Node {
    Node {
        val,
        neighbors: vec![],
    }
}

pub fn build_graph(adj_list: Vec<Vec<i32>>) -> Option<Box<Node>> {
    if adj_list.is_empty() {
        return None;
    }

    let n = adj_list.len();
    let nodes: Vec<Box<Node>> = (0..n).map(|i| Box::new(Node { val: i as i32, neighbors: vec![] })).collect();

    for i in 0..n {
        for &neighbor in &adj_list[i] {
            nodes[i].neighbors.push(nodes[neighbor as usize].clone());
        }
    }

    Some(nodes[0].clone())
}

impl Solution {
    pub fn all_paths_source_target(root: Option<Box<Node>>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut path = Vec::new();

        if let Some(node) = root {
            path.push(node.val);
            self.dfs(&node, &mut path, &mut result);
            path.pop();
        }

        result
    }

    fn dfs(node: &Box<Node>, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        if node.val == (node.neighbors.len() as i32 - 1) {
            result.push(path.clone());
            return;
        }

        for neighbor in &node.neighbors {
            path.push(neighbor.val);
            Self::dfs(neighbor, path, result);
            path.pop();
        }
    }
}
}