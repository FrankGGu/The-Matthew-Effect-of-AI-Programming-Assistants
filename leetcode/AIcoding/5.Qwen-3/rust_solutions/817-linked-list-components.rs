impl Solution {


use std::collections::HashSet;

impl Solution {
    pub fn is_connected(head: Option<Box<ListNode>>, nums: Vec<i32>) -> i32 {
        let set: HashSet<i32> = nums.into_iter().collect();
        let mut count = 0;
        let mut current = head;
        while let Some(node) = current {
            if set.contains(&node.val) {
                count += 1;
                while let Some(next) = node.next {
                    if set.contains(&next.val) {
                        current = Some(next);
                    } else {
                        break;
                    }
                }
            }
            current = node.next;
        }
        count
    }
}
}