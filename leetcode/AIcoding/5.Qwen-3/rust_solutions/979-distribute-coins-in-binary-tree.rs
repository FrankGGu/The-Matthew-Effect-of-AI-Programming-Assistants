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

pub struct Solution {}

impl Solution {
    pub fn distribute_coins(root: Option<Box<TreeNode>>) -> i32 {
        fn dfs(node: &Option<Box<TreeNode>>, result: &mut i32) -> i32 {
            if let Some(n) = node {
                let left = dfs(&n.left, result);
                let right = dfs(&n.right, result);
                *result += left.abs() + right.abs();
                n.val + left + right
            } else {
                0
            }
        }

        let mut res = 0;
        dfs(&root, &mut res);
        res
    }
}
}