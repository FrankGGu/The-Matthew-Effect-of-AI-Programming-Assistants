impl Solution {

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

pub fn add_two_numbers(
    l1: Option<Box<ListNode>>,
    l2: Option<Box<ListNode>>,
) -> Option<Box<ListNode>> {
    let mut dummy_head = Box::new(ListNode::new(0));
    let mut p = l1;
    let mut q = l2;
    let mut current = &mut dummy_head;
    let mut carry = 0;

    while p.is_some() || q.is_some() {
        let x = p.as_ref().map_or(0, |node| node.val);
        let y = q.as_ref().map_or(0, |node| node.val);
        let sum = x + y + carry;
        carry = sum / 10;
        current.next = Some(Box::new(ListNode::new(sum % 10)));
        current = current.next.as_mut().unwrap();
        p = p.and_then(|node| node.next);
        q = q.and_then(|node| node.next);
    }

    if carry > 0 {
        current.next = Some(Box::new(ListNode::new(carry)));
    }

    dummy_head.next
}
}