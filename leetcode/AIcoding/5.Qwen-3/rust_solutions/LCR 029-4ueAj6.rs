impl Solution {

use std::cmp::Ordering;
use std::cell::RefCell;
use std::rc::Rc;

#[derive(PartialEq, Eq, Clone, Copy, Debug)]
pub struct Node {
    pub val: i32,
    pub next: Option<Rc<RefCell<Node>>>,
}

impl Node {
    pub fn new(val: i32) -> Self {
        Node { val, next: None }
    }
}

pub fn insert(head: Option<Rc<RefCell<Node>>>, insert_val: i32) -> Option<Rc<RefCell<Node>>> {
    let new_node = Rc::new(RefCell::new(Node::new(insert_val)));

    match head {
        None => {
            new_node.next = Some(new_node.clone());
            return Some(new_node);
        }
        Some(h) => {
            let mut current = h.clone();
            let mut prev = h.clone();

            loop {
                let current_val = current.borrow().val;
                let next_val = current.borrow().next.as_ref().map(|n| n.borrow().val);

                match current_val.cmp(&insert_val) {
                    Ordering::Less => {
                        if next_val.is_none() || next_val.unwrap() >= insert_val {
                            break;
                        }
                    }
                    _ => {
                        if next_val.is_none() || next_val.unwrap() >= insert_val {
                            break;
                        }
                    }
                }

                prev = current.clone();
                current = current.borrow().next.as_ref().unwrap().clone();

                if current == h {
                    break;
                }
            }

            prev.borrow_mut().next = Some(new_node.clone());
            new_node.borrow_mut().next = current.borrow().next.take();

            if current == h {
                new_node.borrow_mut().next = Some(h);
            }

            Some(new_node)
        }
    }
}
}