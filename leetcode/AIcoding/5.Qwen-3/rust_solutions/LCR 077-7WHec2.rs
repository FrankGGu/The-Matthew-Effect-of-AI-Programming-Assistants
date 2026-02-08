impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;
use std::mem::MaybeUninit;

#[derive(PartialEq, Eq, Clone, Copy)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn sort_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    if head.is_none() || head.as_ref().unwrap().next.is_none() {
        return head;
    }

    let mut heap = BinaryHeap::new();
    let mut current = head;

    while let Some(mut node) = current {
        heap.push(std::cmp::Reverse(node.val));
        current = node.next.take();
    }

    let mut dummy = ListNode::new(0);
    let mut current = Some(Box::new(dummy));

    while let Some(val) = heap.pop() {
        let val = val.0;
        let mut new_node = ListNode::new(val);
        current.as_mut().unwrap().next = Some(Box::new(new_node));
        current = current.as_mut().unwrap().next.as_mut();
    }

    current.unwrap().next
}
}