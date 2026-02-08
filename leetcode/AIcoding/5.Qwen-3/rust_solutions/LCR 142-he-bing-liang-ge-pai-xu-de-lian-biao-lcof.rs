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
    pub fn is_sub_structure(root1: Option<Box<TreeNode>>, root2: Option<Box<TreeNode>>) -> bool {
        fn is_same_tree(a: &Option<Box<TreeNode>>, b: &Option<Box<TreeNode>>) -> bool {
            match (a, b) {
                (None, None) => true,
                (Some(n1), Some(n2)) if n1.val == n2.val => {
                    is_same_tree(&n1.left, &n2.left) && is_same_tree(&n1.right, &n2.right)
                }
                _ => false,
            }
        }

        match (root1, root2) {
            (Some(n1), Some(n2)) => {
                is_same_tree(&Some(n1.clone()), &Some(n2.clone()))
                    || Solution::is_sub_structure(n1.left, Some(n2.clone()))
                    || Solution::is_sub_structure(n1.right, Some(n2.clone()))
            }
            _ => false,
        }
    }
}
}