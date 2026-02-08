impl Solution {

use std::ptr::NonNull;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<NonNull<Self>>,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        Self { next: None, val }
    }
}

pub fn insert_greatest_common_divisors(mut head: Option<NonNull<ListNode>>) -> Option<NonNull<ListNode>> {
    let mut current = head;
    while let Some(node) = current {
        let next = unsafe { (*node.as_ptr()).next };
        if let Some(next_node) = next {
            let gcd_val = gcd(unsafe { (*node.as_ptr()).val }, unsafe { (*next_node.as_ptr()).val });
            let new_node = Box::into_raw(Box::new(ListNode::new(gcd_val)));
            unsafe {
                (*node.as_ptr()).next = Some(new_node);
                (*new_node).next = Some(next_node);
            }
            current = Some(next_node);
        } else {
            break;
        }
    }
    head
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}
}