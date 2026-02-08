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

pub fn min_increments(mut root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn dfs(node: &Rc<RefCell<TreeNode>>, res: &mut i32) -> i32 {
        let mut val = node.borrow().val;
        let left = node.borrow().left.as_ref().map(|n| dfs(n, res));
        let right = node.borrow().right.as_ref().map(|n| dfs(n, res));

        let mut max_child = 0;
        if let Some(l) = left {
            max_child = std::cmp::max(max_child, l);
        }
        if let Some(r) = right {
            max_child = std::cmp::max(max_child, r);
        }

        *res += max_child - val;
        max_child + val
    }

    let mut res = 0;
    dfs(&root.unwrap(), &mut res);
    res
}
}