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

pub fn insert_into_bst(
    root: Option<Box<TreeNode>>,
    val: i32,
) -> Option<Box<TreeNode>> {
    if let Some(mut node) = root {
        if val < node.val {
            node.left = insert_into_bst(node.left, val);
        } else {
            node.right = insert_into_bst(node.right, val);
        }
        Some(node)
    } else {
        Some(Box::new(TreeNode::new(val)))
    }
}
}