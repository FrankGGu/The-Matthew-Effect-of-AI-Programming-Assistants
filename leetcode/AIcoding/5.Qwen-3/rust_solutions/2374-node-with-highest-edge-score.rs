impl Solution {

use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub neighbors: Vec<Node>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node { val, neighbors: vec![] }
    }
}

pub fn most_connected_node(head: Option<Box<Node>>) -> i32 {
    let mut edge_scores = std::collections::HashMap::new();
    let mut queue = VecDeque::new();

    if let Some(head) = head {
        queue.push_back(head);
    }

    while let Some(node) = queue.pop_front() {
        for neighbor in &node.neighbors {
            *edge_scores.entry(neighbor.val).or_insert(0) += 1;
        }

        for neighbor in &node.neighbors {
            queue.push_back(neighbor.clone());
        }
    }

    let mut max_score = -1;
    let mut result = 0;

    for (&val, &score) in edge_scores.iter() {
        if score > max_score || (score == max_score && val < result) {
            max_score = score;
            result = val;
        }
    }

    result
}
}