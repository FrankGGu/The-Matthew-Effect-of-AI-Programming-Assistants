impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

#[derive(PartialEq, Eq)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Rc<RefCell<ListNode>>>
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn is_palindrome(head: Option<Rc<RefCell<ListNode>>>) -> bool {
    let mut slow = head.clone();
    let mut fast = head.clone();

    while let Some(f) = fast {
        if let Some(n) = f.next {
            fast = n.next;
        } else {
            break;
        }

        if let Some(n) = slow {
            slow = n.next;
        }
    }

    let mut second_half = slow;
    let mut prev = None;

    while let Some(mut curr) = second_half {
        let next = curr.next;
        curr.next = prev;
        prev = Some(curr);
        second_half = next;
    }

    let mut left = head;
    let mut right = prev;

    while let (Some(l), Some(r)) = (left, right) {
        if l.val != r.val {
            return false;
        }

        left = l.next;
        right = r.next;
    }

    true
}
}