impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

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

pub fn reorder_list(head: Option<Rc<RefCell<ListNode>>>) {
    if head.is_none() || head.as_ref().unwrap().borrow().next.is_none() {
        return;
    }

    let mut slow = head.clone();
    let mut fast = head.clone();

    while let (Some(s), Some(f)) = (slow, fast) {
        slow = s.borrow().next.clone();
        fast = f.borrow().next.as_ref().and_then(|n| n.borrow().next.clone());
    }

    let mut second_half = slow;
    let mut prev = None;

    while let Some(mut node) = second_half {
        let next = node.borrow().next.clone();
        node.borrow_mut().next = prev;
        prev = Some(node);
        second_half = next;
    }

    let mut first = head;
    let mut second = prev;

    while let (Some(f), Some(s)) = (first, second) {
        let f_next = f.borrow().next.clone();
        let s_next = s.borrow().next.clone();

        f.borrow_mut().next = Some(s.clone());
        s.borrow_mut().next = f_next;

        first = f_next;
        second = s_next;
    }
}
}