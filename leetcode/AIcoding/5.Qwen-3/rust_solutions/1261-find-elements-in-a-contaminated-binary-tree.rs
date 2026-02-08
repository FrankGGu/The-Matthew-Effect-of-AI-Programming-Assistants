impl Solution {

use std::collections::HashSet;
use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub struct FindElements {
    set: HashSet<i32>,
}

impl FindElements {
    fn new(root: Option<Rc<RefCell<TreeNode>>>) -> Self {
        let mut set = HashSet::new();
        if let Some(node) = root {
            Self::recover(&node, 0, &mut set);
        }
        FindElements { set }
    }

    fn recover(node: &Rc<RefCell<TreeNode>>, val: i32, set: &mut HashSet<i32>) {
        set.insert(val);
        let node_ref = node.borrow();
        if let Some(left) = &node_ref.left {
            Self::recover(left, 2 * val + 1, set);
        }
        if let Some(right) = &node_ref.right {
            Self::recover(right, 2 * val + 2, set);
        }
    }

    pub fn find(&self, target: i32) -> bool {
        self.set.contains(&target)
    }
}
}