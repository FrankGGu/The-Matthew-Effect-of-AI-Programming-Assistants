class Solution:
    def reverseKGroup(self, head: ListNode, k: int) -> ListNode:
        def reverse(start, end):
            prev = None
            curr = start
            while curr != end:
                next_node = curr.next
                curr.next = prev
                prev = curr
                curr = next_node
            return prev

        dummy = ListNode(0)
        dummy.next = head
        prev = dummy
        curr = head

        while True:
            count = 0
            temp = curr
            while count < k and temp:
                temp = temp.next
                count += 1
            if count < k:
                break
            next_group = temp
            reversed_head = reverse(curr, next_group)
            prev.next = reversed_head
            prev = curr
            curr = next_group

        return dummy.next