impl Solution {

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn sorted_list_to_bst(head: Option<Box<ListNode>>) -> Option<Box<TreeNode>> {
        let mut nums = Vec::new();
        let mut current = head;
        while let Some(node) = current {
            nums.push(node.val);
            current = node.next;
        }
        Self::sorted_array_to_bst(&nums)
    }

    fn sorted_array_to_bst(nums: &[i32]) -> Option<Box<TreeNode>> {
        if nums.is_empty() {
            return None;
        }
        let mid = nums.len() / 2;
        Some(Box::new(TreeNode {
            val: nums[mid],
            left: Self::sorted_array_to_bst(&nums[..mid]),
            right: Self::sorted_array_to_bst(&nums[mid + 1..]),
        }))
    }
}
}