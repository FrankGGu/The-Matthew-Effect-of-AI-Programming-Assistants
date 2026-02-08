impl Solution {

use std::cell::RefCell;
use std::collections::HashSet;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn find_target(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> bool {
    let mut set = HashSet::new();
    let mut stack = vec![];
    let mut current = root;

    while let Some(node) = current {
        let node_ref = node.borrow();
        if set.contains(&node_ref.val) {
            return true;
        }
        set.insert(k - node_ref.val);
        current = match node_ref.left {
            Some(ref left) => Some(left.clone()),
            None => {
                let right = node_ref.right.clone();
                current = None;
                if let Some(right) = right {
                    current = Some(right);
                }
                None
            }
        };
    }

    false
}
}