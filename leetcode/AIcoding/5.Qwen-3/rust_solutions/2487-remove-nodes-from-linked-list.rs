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

pub fn remove_nodes(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut stack = Vec::new();
    let mut current = head.as_ref();

    while let Some(node) = current {
        while let Some(last) = stack.last() {
            if last.val >= node.val {
                break;
            }
            stack.pop();
        }
        stack.push(node);
        current = node.next.as_ref();
    }

    let mut result = None;
    while let Some(node) = stack.pop() {
        let mut new_node = Box::new(ListNode::new(node.val));
        new_node.next = result;
        result = Some(new_node);
    }

    result
}
}