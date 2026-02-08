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

pub fn bst_to_gst(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    let mut sum = 0;
    fn dfs(node: &mut Option<Box<TreeNode>>, sum: &mut i32) {
        if let Some(ref mut node) = node {
            dfs(&mut node.right, sum);
            *sum += node.val;
            node.val = *sum;
            dfs(&mut node.left, sum);
        }
    }
    dfs(&mut root, &mut sum);
    root
}
}