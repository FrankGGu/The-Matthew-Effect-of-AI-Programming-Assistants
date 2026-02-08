impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<TreeNode>,
    pub right: Option<TreeNode>,
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

pub struct Solution {}

impl Solution {
    pub fn schedule_tasks(root: Option<Box<TreeNode>>) -> i32 {
        fn dfs(node: &Option<Box<TreeNode>>, depth: i32) -> i32 {
            if let Some(n) = node {
                let left = dfs(&n.left, depth + 1);
                let right = dfs(&n.right, depth + 1);
                return left.max(right);
            }
            depth
        }

        dfs(&root, 0)
    }
}
}