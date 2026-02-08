impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn is_unival_tree(root: Option<Box<TreeNode>>) -> bool {
    fn helper(node: &Option<Box<TreeNode>>, val: i32) -> bool {
        match node {
            None => true,
            Some(n) => n.val == val && helper(&n.left, val) && helper(&n.right, val),
        }
    }

    match root {
        None => true,
        Some(n) => helper(&Some(n), n.val),
    }
}
}