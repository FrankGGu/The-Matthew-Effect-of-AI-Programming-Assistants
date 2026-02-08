impl Solution {
    pub fn nodes_between_critical_points(head: Option<Box<ListNode>>) -> Vec<i32> {
        let mut result = vec![-1, -1];
        let mut first = -1;
        let mut last = -1;
        let mut min_dist = i32::MAX;
        let mut index = 0;
        let mut prev = head.as_ref();

        while let Some(node) = prev {
            let next = node.next.as_ref();
            if next.is_none() {
                break;
            }
            let next_next = next.as_ref().unwrap().next.as_ref();
            if next_next.is_none() {
                break;
            }

            let is_critical = (node.val > next.as_ref().unwrap().val && node.val > next_next.as_ref().unwrap().val)
                || (node.val < next.as_ref().unwrap().val && node.val < next_next.as_ref().unwrap().val);

            if is_critical {
                if first == -1 {
                    first = index;
                } else {
                    min_dist = std::cmp::min(min_dist, index - last);
                }
                last = index;
            }

            prev = next;
            index += 1;
        }

        if first == -1 || last == first {
            return result;
        }

        result[0] = min_dist;
        result[1] = last - first;
        result
    }
}