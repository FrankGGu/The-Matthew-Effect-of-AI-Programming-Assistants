impl Solution {

use std::cmp::Ordering;

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

pub fn mct_from_leaf_tree(mut leaves: Vec<i32>) -> i32 {
    let mut res = 0;
    while leaves.len() > 1 {
        let mut min_index = 0;
        let mut min_val = leaves[0];
        for i in 1..leaves.len() {
            if leaves[i] < min_val {
                min_val = leaves[i];
                min_index = i;
            }
        }
        let mut min_right = leaves[min_index + 1];
        let mut min_right_index = min_index + 1;
        for i in min_index + 2..leaves.len() {
            if leaves[i] < min_right {
                min_right = leaves[i];
                min_right_index = i;
            }
        }
        let mut min_left = leaves[min_index - 1];
        let mut min_left_index = min_index - 1;
        for i in 0..min_index {
            if leaves[i] < min_left {
                min_left = leaves[i];
                min_left_index = i;
            }
        }
        let (left, right) = if min_left_index < min_right_index {
            (min_left, min_right)
        } else {
            (min_right, min_left)
        };
        res += left * right;
        leaves.remove(min_index);
        leaves.remove(min_index);
        leaves.insert(min_index, left * right);
    }
    res
}
}