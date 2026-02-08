impl Solution {

use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn largest_values(root: Option<Box<TreeNode>>) -> Vec<i32> {
    let mut result = Vec::new();
    if root.is_none() {
        return result;
    }

    let mut queue = VecDeque::new();
    queue.push_back(root.unwrap());

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut max_val = i32::MIN;

        for _ in 0..level_size {
            if let Some(node) = queue.pop_front() {
                max_val = max_val.max(node.val);
                if let Some(left) = node.left {
                    queue.push_back(left);
                }
                if let Some(right) = node.right {
                    queue.push_back(right);
                }
            }
        }

        result.push(max_val);
    }

    result
}
}