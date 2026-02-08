impl Solution {

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

pub fn double_linked_list(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = Box::new(ListNode::new(0));
    let mut current = head;
    let mut carry = 0;

    while let Some(mut node) = current {
        let total = node.val * 2 + carry;
        carry = total / 10;
        node.val = total % 10;
        dummy.next = Some(node);
        current = dummy.next.as_mut().and_then(|n| n.next.take());
    }

    if carry > 0 {
        dummy.next = Some(Box::new(ListNode::new(carry)));
    }

    dummy.next
}
}