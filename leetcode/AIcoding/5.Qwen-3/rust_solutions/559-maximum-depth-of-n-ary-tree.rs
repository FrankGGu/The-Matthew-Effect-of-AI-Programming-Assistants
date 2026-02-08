impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub children: Vec<Rc<RefCell<Node>>>,
}

impl Node {
    pub fn new(val: i32) -> Self {
        Node {
            val,
            children: vec![],
        }
    }
}

pub fn max_depth(root: Option<Rc<RefCell<Node>>>) -> i32 {
    match root {
        None => 0,
        Some(node) => {
            let mut max_child_depth = 0;
            for child in &node.borrow().children {
                max_child_depth = std::cmp::max(max_child_depth, max_depth(Some(child.clone())));
            }
            max_child_depth + 1
        }
    }
}
}