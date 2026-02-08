impl Solution {

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

pub fn min_depth(root: Option<Box<TreeNode>>) -> i32 {
    match root {
        None => 0,
        Some(node) => {
            let left = min_depth(node.left);
            let right = min_depth(node.right);
            if left == 0 && right == 0 {
                1
            } else if left == 0 {
                right + 1
            } else if right == 0 {
                left + 1
            } else {
                left.min(right) + 1
            }
        }
    }
}
}