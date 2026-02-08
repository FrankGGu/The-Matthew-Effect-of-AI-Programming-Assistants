impl Solution {

use std::collections::{LinkedList, VecDeque};

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn zigzag_level_order(root: Option<Box<TreeNode>>) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    if root.is_none() {
        return result;
    }

    let mut queue = VecDeque::new();
    queue.push_back(root);

    let mut left_to_right = true;

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut level_nodes = Vec::with_capacity(level_size);

        for _ in 0..level_size {
            let node = queue.pop_front().unwrap();
            level_nodes.push(node.val);

            if let Some(left) = &node.left {
                queue.push_back(Some(Box::new(*left.clone())));
            }
            if let Some(right) = &node.right {
                queue.push_back(Some(Box::new(*right.clone())));
            }
        }

        if !left_to_right {
            level_nodes.reverse();
        }

        result.push(level_nodes);
        left_to_right = !left_to_right;
    }

    result
}
}