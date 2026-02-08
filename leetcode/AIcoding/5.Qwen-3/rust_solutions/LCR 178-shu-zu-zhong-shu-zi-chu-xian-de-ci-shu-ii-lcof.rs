impl Solution {

use std::collections::VecDeque;

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

pub fn reverse_even_levels(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    if root.is_none() {
        return None;
    }

    let mut queue = VecDeque::new();
    queue.push_back(root.clone());

    let mut level = 0;

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut level_nodes = Vec::new();

        for _ in 0..level_size {
            if let Some(node) = queue.pop_front() {
                level_nodes.push(node);
                if let Some(left) = &node.left {
                    queue.push_back(Some(Box::new(TreeNode {
                        val: left.val,
                        left: left.left.clone(),
                        right: left.right.clone(),
                    })));
                }
                if let Some(right) = &node.right {
                    queue.push_back(Some(Box::new(TreeNode {
                        val: right.val,
                        left: right.left.clone(),
                        right: right.right.clone(),
                    })));
                }
            }
        }

        if level % 2 == 0 {
            let mut left = 0;
            let mut right = level_nodes.len() - 1;

            while left < right {
                let left_val = level_nodes[left].val;
                level_nodes[left].val = level_nodes[right].val;
                level_nodes[right].val = left_val;

                left += 1;
                right -= 1;
            }
        }

        level += 1;
    }

    root
}
}