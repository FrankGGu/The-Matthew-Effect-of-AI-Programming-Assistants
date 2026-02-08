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

pub fn middle_node(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut slow = head;
    let mut fast = head;

    while let (Some(s), Some(f)) = (slow.as_ref(), fast.as_ref()) {
        slow = s.next.clone();
        fast = f.next.as_ref().and_then(|n| n.next.clone());
    }

    slow
}