impl Solution {

use std::collections::{HashMap, VecDeque};

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub neighbors: Vec<Node>,
}

impl Node {
    pub fn new(val: i32) -> Self {
        Node {
            val,
            neighbors: Vec::new(),
        }
    }
}

pub fn clone_graph(node: Option<Box<Node>>) -> Option<Box<Node>> {
    if node.is_none() {
        return None;
    }

    let mut map = HashMap::new();
    let queue = VecDeque::new();

    let original_node = node.unwrap();
    let cloned_node = Box::new(Node::new(original_node.val));
    map.insert(original_node.val, cloned_node.clone());
    queue.push_back(original_node);

    while let Some(current) = queue.pop_front() {
        for neighbor in current.neighbors {
            if !map.contains_key(&neighbor.val) {
                let cloned_neighbor = Box::new(Node::new(neighbor.val));
                map.insert(neighbor.val, cloned_neighbor.clone());
                queue.push_back(neighbor);
            }
            map.get_mut(&current.val).unwrap().neighbors.push(map[&neighbor.val].clone());
        }
    }

    Some(map.remove(&original_node.val).unwrap())
}
}