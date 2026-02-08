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

pub fn is_balanced(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
    fn height(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
        match node {
            None => 0,
            Some(n) => {
                let left = height(&n.borrow().left);
                let right = height(&n.borrow().right);
                if left == -1 || right == -1 || (left - right).abs() > 1 {
                    -1
                } else {
                    1 + std::cmp::max(left, right)
                }
            }
        }
    }

    height(&root) != -1
}
}