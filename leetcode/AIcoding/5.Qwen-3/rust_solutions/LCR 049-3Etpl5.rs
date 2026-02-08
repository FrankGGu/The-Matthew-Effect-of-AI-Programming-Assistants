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

pub fn sum_numbers(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, current_sum: i32) -> i32 {
        match node {
            Some(n) => {
                let new_sum = current_sum * 10 + n.val;
                if n.left.is_none() && n.right.is_none() {
                    new_sum
                } else {
                    dfs(&n.left, new_sum) + dfs(&n.right, new_sum)
                }
            }
            None => 0,
        }
    }

    dfs(&root, 0)
}
}