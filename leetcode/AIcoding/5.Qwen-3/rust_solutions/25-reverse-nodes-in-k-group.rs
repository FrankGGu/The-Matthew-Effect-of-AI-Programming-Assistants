impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Rc<RefCell<ListNode>>>,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn reverse_k_group(
    head: Option<Rc<RefCell<ListNode>>>,
    k: i32,
) -> Option<Rc<RefCell<ListNode>>> {
    let mut dummy = Rc::new(RefCell::new(ListNode::new(0)));
    dummy.borrow_mut().next = head;

    let mut current = Rc::clone(&dummy);
    let mut count = 0;

    while let Some(node) = current.borrow().next.as_ref() {
        count += 1;
        current = Rc::clone(node);
    }

    let mut prev = Rc::clone(&dummy);
    let mut curr = prev.borrow().next.clone();

    while count >= k {
        let mut next_group = curr.as_ref().unwrap().borrow().next.clone();
        let mut tail = Rc::clone(&curr);

        for _ in 0..k {
            let temp = curr.as_ref().unwrap().borrow().next.clone();
            curr.as_ref().unwrap().borrow_mut().next = prev.borrow().next.clone();
            prev.borrow_mut().next = curr;
            curr = temp;
        }

        tail.as_ref().unwrap().borrow_mut().next = curr;
        prev = tail;
        count -= k;
    }

    dummy.borrow().next.clone()
}
}