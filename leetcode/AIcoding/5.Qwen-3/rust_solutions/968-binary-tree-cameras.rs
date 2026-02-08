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

pub struct Solution {}

impl Solution {
    pub fn min_camera_cover(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut count = 0;
        fn dfs(node: Option<&Rc<RefCell<TreeNode>>>, count: &mut i32) -> i32 {
            if let Some(n) = node {
                let left = dfs(n.borrow().left.as_ref(), count);
                let right = dfs(n.borrow().right.as_ref(), count);
                if left == 0 || right == 0 {
                    *count += 1;
                    return 1;
                } else if left == 1 || right == 1 {
                    return 0;
                } else {
                    return 2;
                }
            }
            0
        }
        if dfs(root.as_ref(), &mut count) == 0 {
            count += 1;
        }
        count
    }
}
}