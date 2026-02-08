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

pub fn remove_leaf_nodes(mut root: Option<Box<TreeNode>>, target: i32) -> Option<Box<TreeNode>> {
    fn dfs(node: &mut Option<Box<TreeNode>>, target: i32) {
        if let Some(ref mut n) = node {
            dfs(&mut n.left, target);
            dfs(&mut n.right, target);
            if n.left.is_none() && n.right.is_none() && n.val == target {
                *node = None;
            }
        }
    }

    dfs(&mut root, target);
    root
}
}