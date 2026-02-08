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

pub fn inorder_successor(root: Option<Rc<RefCell<TreeNode>>>, p: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
    let mut successor = None;
    let mut current = root;

    while let Some(node) = current {
        let node_ref = node.borrow();
        if node_ref.val > p.as_ref().unwrap().borrow().val {
            successor = Some(node.clone());
            current = node_ref.left.clone();
        } else {
            current = node_ref.right.clone();
        }
    }

    successor
}
}