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

pub fn sufficient_subset(root: Option<Box<TreeNode>>, limit: i32) -> Option<Box<TreeNode>> {
    fn dfs(node: Option<Box<TreeNode>>, limit: i32, current_sum: i32) -> Option<Box<TreeNode>> {
        if let Some(mut node) = node {
            let left = dfs(node.left, limit, current_sum + node.val);
            let right = dfs(node.right, limit, current_sum + node.val);
            if left.is_none() && right.is_none() {
                if current_sum + node.val < limit {
                    return None;
                }
            }
            node.left = left;
            node.right = right;
            Some(node)
        } else {
            None
        }
    }

    dfs(root, limit, 0)
}
}