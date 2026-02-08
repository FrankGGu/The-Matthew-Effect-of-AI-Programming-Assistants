class Solution:
    def partition(self, head: ListNode, x: int) -> ListNode:
        before = ListNode(0)
        after = ListNode(0)
        before_curr = before
        after_curr = after

        while head:
            if head.val < x:
                before_curr.next = head
                before_curr = head
            else:
                after_curr.next = head
                after_curr = head
            head = head.next

        after_curr.next = None
        before_curr.next = after.next

        return before.next