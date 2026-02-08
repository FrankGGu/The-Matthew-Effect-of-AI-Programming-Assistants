impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

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

pub fn is_subtree(s: Option<Rc<RefCell<TreeNode>>>, t: Option<Rc<RefCell<TreeNode>>>) -> bool {
    fn is_same_tree(s: &Option<Rc<RefCell<TreeNode>>>, t: &Option<Rc<RefCell<TreeNode>>>) -> bool {
        match (s, t) {
            (None, None) => true,
            (Some(s_node), Some(t_node)) => {
                s_node.borrow().val == t_node.borrow().val
                    && is_same_tree(&s_node.borrow().left, &t_node.borrow().left)
                    && is_same_tree(&s_node.borrow().right, &t_node.borrow().right)
            }
            _ => false,
        }
    }

    match s {
        None => t.is_none(),
        Some(s_node) => {
            is_same_tree(&Some(s_node.clone()), &t)
                || is_subtree(s_node.borrow().left.clone(), t)
                || is_subtree(s_node.borrow().right.clone(), t)
        }
    }
}
}