impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn longest_zigzag_path(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, is_left: bool, length: i32, max_length: &mut i32) {
        if let Some(n) = node {
            let new_length = if is_left { length + 1 } else { length + 1 };
            *max_length = std::cmp::max(*max_length, new_length);
            dfs(&n.left, false, new_length, max_length);
            dfs(&n.right, true, new_length, max_length);
        }
    }

    let mut max_length = 0;
    if let Some(n) = &root {
        dfs(&n.left, false, 0, &mut max_length);
        dfs(&n.right, true, 0, &mut max_length);
    }
    max_length
}
}