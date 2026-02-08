impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
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

pub fn trim_bst(
    root: Option<Rc<RefCell<TreeNode>>>,
    low: i32,
    high: i32,
) -> Option<Rc<RefCell<TreeNode>>> {
    fn trim(node: &Option<Rc<RefCell<TreeNode>>>, low: i32, high: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(n) = node {
            let mut node = n.borrow_mut();
            if node.val < low {
                return trim(&node.right, low, high);
            } else if node.val > high {
                return trim(&node.left, low, high);
            } else {
                node.left = trim(&node.left, low, high);
                node.right = trim(&node.right, low, high);
                Some(n.clone())
            }
        } else {
            None
        }
    }

    trim(&root, low, high)
}
}