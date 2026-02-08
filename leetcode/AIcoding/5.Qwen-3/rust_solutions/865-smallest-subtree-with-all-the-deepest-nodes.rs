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

pub fn subtree_with_all_deepest(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>) -> (i32, Option<Rc<RefCell<TreeNode>>>) {
        if let Some(n) = node {
            let left = dfs(&n.borrow().left);
            let right = dfs(&n.borrow().right);
            let depth = 1 + std::cmp::max(left.0, right.0);
            if left.0 == right.0 {
                return (depth, Some(n.clone()));
            } else if left.0 > right.0 {
                return (depth, left.1);
            } else {
                return (depth, right.1);
            }
        }
        (0, None)
    }

    dfs(&root).1
}
}