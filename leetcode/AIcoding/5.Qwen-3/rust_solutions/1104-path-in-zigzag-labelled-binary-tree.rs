impl Solution {

use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn path_in_zigzag_labelled_binary_tree(target: i32) -> Vec<i32> {
    let mut result = Vec::new();
    let mut target = target;
    let mut level = 0;
    while (1 << level) <= target {
        level += 1;
    }
    level -= 1;

    while target > 0 {
        result.push(target);
        let mut parent = (target - 1) / 2;
        if level % 2 == 1 {
            let first = 1 << level;
            let last = (1 << (level + 1)) - 1;
            parent = first + last - parent - 1;
        }
        target = parent;
        level -= 1;
    }

    result.reverse();
    result
}
}