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

pub fn is_even_odd_tree(root: Option<Box<TreeNode>>) -> bool {
    if let Some(root) = root {
        let mut queue = VecDeque::new();
        queue.push_back((root, 0));
        let mut prev_val = 0;
        let mut prev_level = -1;

        while let Some((node, level)) = queue.pop_front() {
            if level % 2 == 0 {
                if node.val % 2 == 0 || (level == prev_level && node.val <= prev_val) {
                    return false;
                }
            } else {
                if node.val % 2 != 0 || (level == prev_level && node.val >= prev_val) {
                    return false;
                }
            }

            prev_val = node.val;
            prev_level = level;

            if let Some(left) = node.left {
                queue.push_back((left, level + 1));
            }
            if let Some(right) = node.right {
                queue.push_back((right, level + 1));
            }
        }

        true
    } else {
        true
    }
}
}