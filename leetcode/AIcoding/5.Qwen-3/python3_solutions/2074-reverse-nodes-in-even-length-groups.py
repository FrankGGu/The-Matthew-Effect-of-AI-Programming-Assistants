class Solution:
    def reverseEvenLengthGroups(self, head: Optional[ListNode]) -> Optional[ListNode]:
        def reverse(start, end):
            prev, curr = end, start
            while curr != end:
                next_node = curr.next
                curr.next = prev
                prev = curr
                curr = next_node
            return prev

        group_size = 1
        current = head
        prev = None
        while current:
            count = 0
            first = current
            while current and count < group_size:
                current = current.next
                count += 1
            if count % 2 == 0:
                prev = reverse(first, current)
            else:
                prev = first
            group_size += 1
        return head