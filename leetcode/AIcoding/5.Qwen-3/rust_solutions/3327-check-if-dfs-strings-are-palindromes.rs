impl Solution {

use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub type RcRefCellTreeNode = Rc<RefCell<TreeNode>>;

pub fn is_palindrome(root: Option<RcRefCellTreeNode>) -> bool {
    let mut queue = VecDeque::new();
    queue.push_back(root);

    while let Some(node) = queue.pop_front() {
        let mut level_vals = Vec::new();
        let mut next_level = VecDeque::new();

        if let Some(n) = node {
            let node_ref = n.borrow();
            level_vals.push(node_ref.val);

            if let Some(left) = &node_ref.left {
                next_level.push_back(Some(left.clone()));
            }
            if let Some(right) = &node_ref.right {
                next_level.push_back(Some(right.clone()));
            }
        }

        if !level_vals.is_empty() {
            let len = level_vals.len();
            for i in 0..len / 2 {
                if level_vals[i] != level_vals[len - 1 - i] {
                    return false;
                }
            }
        }

        queue = next_level;
    }

    true
}
}