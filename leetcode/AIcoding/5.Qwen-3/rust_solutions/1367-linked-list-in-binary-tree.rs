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
    pub fn is_sub_path(
        head: Option<Box<ListNode>>,
        root: Option<Box<TreeNode>>,
    ) -> bool {
        fn dfs(head: &Option<Box<ListNode>>, root: &Option<Box<TreeNode>>) -> bool {
            if head.is_none() {
                return true;
            }
            if root.is_none() {
                return false;
            }
            let head_val = head.as_ref().unwrap().val;
            let root_val = root.as_ref().unwrap().val;
            if head_val == root_val && match_head(head, root) {
                return true;
            }
            dfs(head, &root.as_ref().unwrap().left) || dfs(head, &root.as_ref().unwrap().right)
        }

        fn match_head(
            head: &Option<Box<ListNode>>,
            root: &Option<Box<TreeNode>>,
        ) -> bool {
            if head.is_none() {
                return true;
            }
            if root.is_none() {
                return false;
            }
            let head_val = head.as_ref().unwrap().val;
            let root_val = root.as_ref().unwrap().val;
            if head_val != root_val {
                return false;
            }
            match_head(&head.as_ref().unwrap().next, &root.as_ref().unwrap().left) ||
                match_head(&head.as_ref().unwrap().next, &root.as_ref().unwrap().right)
        }

        dfs(&head, &root)
    }
}
}