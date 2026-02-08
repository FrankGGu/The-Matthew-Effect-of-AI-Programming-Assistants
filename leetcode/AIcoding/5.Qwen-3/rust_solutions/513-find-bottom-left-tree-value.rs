impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn find_bottom_left_tree_value(root: Option<Box<TreeNode>>) -> i32 {
    use std::collections::VecDeque;

    let mut queue = VecDeque::new();
    if let Some(node) = root {
        queue.push_back(node);
    }

    let mut result = 0;
    while !queue.is_empty() {
        let level_size = queue.len();
        for i in 0..level_size {
            if let Some(node) = queue.pop_front() {
                if i == 0 {
                    result = node.val;
                }
                if let Some(left) = node.left {
                    queue.push_back(left);
                }
                if let Some(right) = node.right {
                    queue.push_back(right);
                }
            }
        }
    }

    result
}
}