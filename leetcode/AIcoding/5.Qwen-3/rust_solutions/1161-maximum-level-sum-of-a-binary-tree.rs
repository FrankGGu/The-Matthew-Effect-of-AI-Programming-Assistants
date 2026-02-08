impl Solution {

use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn max_level_sum(root: Option<Box<TreeNode>>) -> i32 {
    let mut max_sum = i32::MIN;
    let mut level = 0;
    let mut queue = VecDeque::new();

    if let Some(node) = root {
        queue.push_back(node);
    }

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut current_sum = 0;

        for _ in 0..level_size {
            if let Some(node) = queue.pop_front() {
                current_sum += node.val;

                if let Some(left) = node.left {
                    queue.push_back(left);
                }

                if let Some(right) = node.right {
                    queue.push_back(right);
                }
            }
        }

        if current_sum > max_sum {
            max_sum = current_sum;
            level += 1;
        }
    }

    level
}
}