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

pub fn inorder_traversal(root: Option<Box<TreeNode>>) -> Vec<i32> {
    let mut result = Vec::new();
    let mut stack = Vec::new();
    let mut current = root;

    while current.is_some() || !stack.is_empty() {
        while let Some(node) = current {
            stack.push(node);
            current = node.left;
        }

        if let Some(node) = stack.pop() {
            result.push(node.val);
            current = node.right;
        }
    }

    result
}
}