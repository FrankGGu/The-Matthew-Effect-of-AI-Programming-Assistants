impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn number_of_nodes(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn count_nodes(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
        match node {
            Some(n) => {
                let n_ref = n.borrow();
                1 + count_nodes(&n_ref.left) + count_nodes(&n_ref.right)
            }
            None => 0,
        }
    }

    count_nodes(&root)
}
}