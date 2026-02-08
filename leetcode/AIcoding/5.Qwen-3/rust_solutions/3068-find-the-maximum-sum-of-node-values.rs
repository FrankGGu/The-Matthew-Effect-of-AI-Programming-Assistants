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

pub fn max_sum_of_node_values(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn dfs(node: &Rc<RefCell<TreeNode>>) -> (i32, i32) {
        let mut take = node.borrow().val;
        let mut not_take = 0;

        if let Some(left) = &node.borrow().left {
            let (t, nt) = dfs(left);
            take += nt;
            not_take += t.max(nt);
        }

        if let Some(right) = &node.borrow().right {
            let (t, nt) = dfs(right);
            take += nt;
            not_take += t.max(nt);
        }

        (take, not_take)
    }

    match root {
        Some(node) => {
            let (t, nt) = dfs(&node);
            t.max(nt)
        }
        None => 0,
    }
}
}