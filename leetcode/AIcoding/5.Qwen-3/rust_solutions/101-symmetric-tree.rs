impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn is_symmetric(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
    fn is_same(
        left: Option<Rc<RefCell<TreeNode>>>,
        right: Option<Rc<RefCell<TreeNode>>>,
    ) -> bool {
        match (left, right) {
            (None, None) => true,
            (Some(l), Some(r)) => {
                l.borrow().val == r.borrow().val
                    && is_same(l.borrow().left.clone(), r.borrow().right.clone())
                    && is_same(l.borrow().right.clone(), r.borrow().left.clone())
            }
            _ => false,
        }
    }

    is_same(root.clone(), root)
}
}