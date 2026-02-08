impl Solution {

use std::collections::HashSet;

#[derive(PartialEq, Eq, Clone, Debug)]
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

pub fn detect_cycle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut seen = HashSet::new();
    let mut current = head;

    while let Some(node) = current {
        if seen.contains(&node) {
            return Some(node);
        }
        seen.insert(node);
        current = node.next;
    }

    None
}
}