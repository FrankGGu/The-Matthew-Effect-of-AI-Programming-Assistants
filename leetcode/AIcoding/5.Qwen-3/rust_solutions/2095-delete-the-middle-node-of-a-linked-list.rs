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

pub fn delete_middle(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
    let mut slow = &mut dummy;
    let mut fast = &mut dummy;

    while let Some(f) = fast.as_ref() {
        if f.next.is_none() {
            break;
        }
        fast = &mut f.next;
        if let Some(s) = slow.as_mut() {
            slow = &mut s.next;
        }
    }

    if let Some(mut s) = slow.as_mut() {
        s.next = s.next.as_ref().and_then(|n| n.next.clone());
    }

    dummy.unwrap().next
}
}