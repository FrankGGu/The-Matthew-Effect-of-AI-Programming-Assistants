impl Solution {

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn training_plan(head: Option<Box<ListNode>>, cnt: i32) -> Option<Box<ListNode>> {
    let mut fast = head.clone();
    let mut slow = head;
    for _ in 0..cnt {
        if let Some(node) = fast {
            fast = node.next;
        } else {
            return None;
        }
    }
    while let Some(node) = fast {
        fast = node.next;
        if let Some(s) = slow {
            slow = s.next;
        } else {
            return None;
        }
    }
    slow
}
}