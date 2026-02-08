impl Solution {

use std::rc::Rc;
use std::cell::RefCell;
use std::vec::Vec;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub children: Vec<Rc<RefCell<Node>>>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node {
            val,
            children: vec![],
        }
    }
}

impl Solution {
    pub fn postorder(root: Option<Rc<RefCell<Node>>>) -> Vec<i32> {
        let mut result = Vec::new();
        if let Some(node) = root {
            let mut stack = vec![node];
            while let Some(current) = stack.pop() {
                let mut current_borrow = current.borrow_mut();
                result.push(current_borrow.val);
                for child in current_borrow.children.iter().rev() {
                    stack.push(child.clone());
                }
            }
        }
        result.reverse();
        result
    }
}
}