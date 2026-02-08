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

pub fn increasing_bst(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    let mut dummy = Box::new(TreeNode::new(0));
    let mut current = &mut dummy;

    fn inorder(node: Option<Box<TreeNode>>, current: &mut Box<TreeNode>) {
        if let Some(mut node) = node {
            inorder(node.left.take(), current);
            current.right = Some(node);
            current = current.right.as_mut().unwrap();
            inorder(node.right.take(), current);
        }
    }

    inorder(root, &mut dummy);

    dummy.right
}
}