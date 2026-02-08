impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn find_target(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> bool {
    let mut set = std::collections::HashSet::new();
    dfs(root, &mut set, k)
}

fn dfs(node: Option<Rc<RefCell<TreeNode>>>, set: &mut std::collections::HashSet<i32>, k: i32) -> bool {
    if let Some(n) = node {
        let val = n.borrow().val;
        if set.contains(&(k - val)) {
            return true;
        }
        set.insert(val);
        if dfs(n.borrow().left.clone(), set, k) {
            return true;
        }
        if dfs(n.borrow().right.clone(), set, k) {
            return true;
        }
    }
    false
}
}