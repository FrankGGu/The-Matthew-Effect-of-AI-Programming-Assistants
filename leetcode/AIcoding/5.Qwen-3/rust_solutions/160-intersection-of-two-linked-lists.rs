impl Solution {

use std::ptr::eq;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

pub fn get_intersection_node(head_a: Option<Box<ListNode>>, head_b: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut a = head_a;
    let mut b = head_b;

    while a.is_some() || b.is_some() {
        if a.as_ref() == b.as_ref() {
            return a;
        }

        a = a.and_then(|node| node.next);
        b = b.and_then(|node| node.next);
    }

    None
}
}