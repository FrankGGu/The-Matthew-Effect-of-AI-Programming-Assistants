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

pub fn count_highest_score(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    let mut max_score = 0;
    let mut count = 0;
    let total_nodes = get_size(&root);

    fn get_size(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if let Some(n) = node {
            let left = get_size(&n.borrow().left);
            let right = get_size(&n.borrow().right);
            left + right + 1
        } else {
            0
        }
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, total: i32, max_score: &mut i32, count: &mut i32) {
        if let Some(n) = node {
            let left = get_size(&n.borrow().left);
            let right = get_size(&n.borrow().right);
            let score = if total == 1 {
                0
            } else {
                let mut s = 1;
                if left > 0 {
                    s *= left;
                }
                if right > 0 {
                    s *= right;
                }
                s
            };

            if score > *max_score {
                *max_score = score;
                *count = 1;
            } else if score == *max_score {
                *count += 1;
            }

            dfs(&n.borrow().left, total, max_score, count);
            dfs(&n.borrow().right, total, max_score, count);
        }
    }

    dfs(&root, total_nodes, &mut max_score, &mut count);
    count
}
}