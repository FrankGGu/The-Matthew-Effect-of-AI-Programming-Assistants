impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn is_complete_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
    let mut queue = vec![root];
    let mut has_null = false;

    while let Some(node) = queue.pop() {
        if let Some(n) = node {
            if has_null {
                return false;
            }
            queue.push(n.borrow().left.clone());
            queue.push(n.borrow().right.clone());
        } else {
            has_null = true;
        }
    }

    true
}
}