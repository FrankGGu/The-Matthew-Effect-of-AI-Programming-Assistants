class Solution:
    def doubleIt(self, head: ListNode) -> ListNode:
        carry = 0
        current = head
        while current:
            new_val = current.val * 2 + carry
            current.val = new_val % 10
            carry = new_val // 10
            current = current.next
        if carry:
            new_node = ListNode(carry)
            new_node.next = head
            head = new_node
        return head