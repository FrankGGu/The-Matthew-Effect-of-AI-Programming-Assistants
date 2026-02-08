impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn is_palindrome(head: Option<Box<ListNode>>) -> bool {
    let mut queue = VecDeque::new();
    let mut current = head;

    while let Some(node) = current {
        queue.push_back(node.val);
        current = node.next;
    }

    while queue.len() > 1 {
        match queue.front() {
            Some(front) => {
                if let Some(back) = queue.back() {
                    if front != back {
                        return false;
                    }
                } else {
                    return false;
                }
            },
            None => return false,
        }
        queue.pop_front();
        queue.pop_back();
    }

    true
}
}