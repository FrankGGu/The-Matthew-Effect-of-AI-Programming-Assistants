class Solution:
    def mergeNodes(self, head: ListNode) -> ListNode:
        dummy = ListNode(0)
        current = dummy
        sum_val = 0
        node = head.next
        while node:
            if node.val == 0:
                current.next = ListNode(sum_val)
                current = current.next
                sum_val = 0
            else:
                sum_val += node.val
            node = node.next
        return dummy.next