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

pub fn lowest_common_ancestor(
    root: Option<Rc<RefCell<TreeNode>>>,
    p: Option<Rc<RefCell<TreeNode>>>,
    q: Option<Rc<RefCell<TreeNode>>>,
) -> Option<Rc<RefCell<TreeNode>>> {
    fn dfs(
        node: Option<Rc<RefCell<TreeNode>>>,
        p: &Rc<RefCell<TreeNode>>,
        q: &Rc<RefCell<TreeNode>>,
    ) -> (bool, bool, Option<Rc<RefCell<TreeNode>>>) {
        if let Some(n) = node {
            let left = dfs(n.borrow().left.clone(), p, q);
            let right = dfs(n.borrow().right.clone(), p, q);

            let has_p = left.0 || right.0 || n.borrow().val == p.borrow().val;
            let has_q = left.1 || right.1 || n.borrow().val == q.borrow().val;

            if has_p && has_q {
                return (true, true, Some(n));
            }

            (has_p, has_q, None)
        } else {
            (false, false, None)
        }
    }

    if let (Some(p), Some(q)) = (p, q) {
        let result = dfs(root, &p, &q);
        result.2
    } else {
        None
    }
}
}