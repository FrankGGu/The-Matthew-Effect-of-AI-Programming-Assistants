impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub left: Option<Rc<RefCell<Node>>>,
    pub right: Option<Rc<RefCell<Node>>>,
    pub next: Option<Rc<RefCell<Node>>>,
}

impl Node {
    pub fn new(val: i32) -> Self {
        Node {
            val,
            left: None,
            right: None,
            next: None,
        }
    }
}

pub fn connect(root: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
    let mut current = root.clone();

    while let Some(node) = current {
        let mut next_level_head = None;
        let mut prev = None;

        let node_ref = node.borrow();
        let mut next_node = node_ref.next.as_ref().map(|n| n.clone());

        while let Some(n) = next_node {
            let n_ref = n.borrow();
            if let Some(left) = &n_ref.left {
                if let Some(p) = &mut prev {
                    p.borrow_mut().next = Some(left.clone());
                } else {
                    next_level_head = Some(left.clone());
                }
                prev = Some(left.clone());
            }

            if let Some(right) = &n_ref.right {
                if let Some(p) = &mut prev {
                    p.borrow_mut().next = Some(right.clone());
                } else {
                    next_level_head = Some(right.clone());
                }
                prev = Some(right.clone());
            }

            next_node = n_ref.next.as_ref().map(|n| n.clone());
        }

        current = next_level_head;
    }

    root
}
}