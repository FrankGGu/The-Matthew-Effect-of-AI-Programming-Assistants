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

pub struct Solution;

impl Solution {
    pub fn spiral_matrix(m: i32, n: i32, head: Option<Box<ListNode>>) -> Vec<Vec<i32>> {
        let m = m as usize;
        let n = n as usize;
        let mut result = vec![vec![0; n]; m];
        let mut current = head;
        let mut top = 0;
        let mut bottom = m - 1;
        let mut left = 0;
        let mut right = n - 1;

        while top <= bottom && left <= right {
            for i in left..=right {
                if let Some(node) = current.as_ref() {
                    result[top][i] = node.val;
                    current = node.next.clone();
                } else {
                    return result;
                }
            }
            top += 1;

            for i in top..=bottom {
                if let Some(node) = current.as_ref() {
                    result[i][right] = node.val;
                    current = node.next.clone();
                } else {
                    return result;
                }
            }
            right -= 1;

            if top > bottom || left > right {
                break;
            }

            for i in (left..=right).rev() {
                if let Some(node) = current.as_ref() {
                    result[bottom][i] = node.val;
                    current = node.next.clone();
                } else {
                    return result;
                }
            }
            bottom -= 1;

            if top > bottom || left > right {
                break;
            }

            for i in (top..=bottom).rev() {
                if let Some(node) = current.as_ref() {
                    result[i][left] = node.val;
                    current = node.next.clone();
                } else {
                    return result;
                }
            }
            left += 1;
        }

        result
    }
}
}