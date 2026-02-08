impl Solution {

use std::cmp::Ordering;
use std::collections::LinkedList;

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

pub fn insertion_sort_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = Box::new(ListNode::new(0));
    let mut current = head;
    while let Some(mut node) = current {
        current = node.next.take();
        let mut prev = &mut dummy;
        while let Some(ref mut next) = prev.next {
            match next.val.cmp(&node.val) {
                Ordering::Less => prev = next,
                _ => break,
            }
        }
        node.next = prev.next.take();
        prev.next = Some(node);
    }
    dummy.next
}
}