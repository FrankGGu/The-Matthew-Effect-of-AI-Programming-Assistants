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

pub fn largest_values(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
    let mut result = Vec::new();
    let mut queue = Vec::new();

    if let Some(node) = root {
        queue.push(node);
    }

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut max_val = i32::MIN;

        for _ in 0..level_size {
            if let Some(current) = queue.pop(0) {
                let current_ref = current.borrow();
                max_val = max_val.max(current_ref.val);

                if let Some(left) = &current_ref.left {
                    queue.push(left.clone());
                }
                if let Some(right) = &current_ref.right {
                    queue.push(right.clone());
                }
            }
        }

        result.push(max_val);
    }

    result
}
}