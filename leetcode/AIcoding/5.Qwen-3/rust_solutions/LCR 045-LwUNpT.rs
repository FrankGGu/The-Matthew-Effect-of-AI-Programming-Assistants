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

pub fn find_bottom_left_value(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    use std::collections::VecDeque;

    let mut queue = VecDeque::new();
    if let Some(node) = root {
        queue.push_back(node);
    }

    let mut result = 0;

    while !queue.is_empty() {
        let level_size = queue.len();
        for i in 0..level_size {
            if let Some(current) = queue.pop_front() {
                if i == 0 {
                    result = current.borrow().val;
                }
                if let Some(left) = &current.borrow().left {
                    queue.push_back(left.clone());
                }
                if let Some(right) = &current.borrow().right {
                    queue.push_back(right.clone());
                }
            }
        }
    }

    result
}
}