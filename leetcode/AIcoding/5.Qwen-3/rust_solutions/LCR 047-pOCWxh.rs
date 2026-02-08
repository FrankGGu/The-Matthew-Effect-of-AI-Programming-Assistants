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

pub fn prune_tree(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    fn helper(node: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
        if let Some(mut node) = node {
            node.left = helper(node.left);
            node.right = helper(node.right);
            if node.left.is_none() && node.right.is_none() && node.val == 0 {
                None
            } else {
                Some(node)
            }
        } else {
            None
        }
    }

    helper(root)
}
}