class Solution:
    def trainningPlan(self, l: ListNode) -> ListNode:
        prev = None
        curr = l
        while curr:
            next_node = curr.next
            curr.next = prev
            prev = curr
            curr = next_node
        return prev