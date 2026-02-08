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

pub fn increasing_order_search_tree(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    let mut result = None;
    let mut current = None;

    fn inorder(
        root: Option<Box<TreeNode>>,
        result: &mut Option<Box<TreeNode>>,
        current: &mut Option<Box<TreeNode>>,
    ) {
        if let Some(mut node) = root {
            inorder(node.left, result, current);
            node.left = None;
            if let Some(ref mut c) = *current {
                c.right = Some(node);
                *current = c.right.as_mut().unwrap();
            } else {
                *result = Some(node);
                *current = result.as_mut().unwrap();
            }
            inorder(node.right, result, current);
        }
    }

    inorder(root, &mut result, &mut current);
    result
}
}