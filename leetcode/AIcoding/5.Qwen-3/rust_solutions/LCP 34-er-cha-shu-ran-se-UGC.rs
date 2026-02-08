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

pub fn min_operation_to_color_tree(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, color: i32) -> i32 {
        if let Some(n) = node {
            let left = dfs(&n.left, color);
            let right = dfs(&n.right, color);
            if n.val == color {
                return 0 + left + right;
            } else {
                return 1 + left + right;
            }
        }
        0
    }

    dfs(&root, 1)
}
}