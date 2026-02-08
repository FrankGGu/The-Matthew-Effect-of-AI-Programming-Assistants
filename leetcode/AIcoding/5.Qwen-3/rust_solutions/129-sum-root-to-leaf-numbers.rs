impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn sum_numbers(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, current_sum: i32, result: &mut i32) {
        if let Some(n) = node {
            let new_sum = current_sum * 10 + n.val;
            if n.left.is_none() && n.right.is_none() {
                *result += new_sum;
                return;
            }
            dfs(&n.left, new_sum, result);
            dfs(&n.right, new_sum, result);
        }
    }

    let mut result = 0;
    dfs(&root, 0, &mut result);
    result
}
}