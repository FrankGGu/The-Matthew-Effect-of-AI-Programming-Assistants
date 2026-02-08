class Solution:
    def pairSum(self, head: ListNode) -> int:
        # Find the middle of the linked list
        slow, fast = head, head
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next

        # Reverse the second half of the linked list
        prev = None
        curr = slow
        while curr:
            next_node = curr.next
            curr.next = prev
            prev = curr
            curr = next_node

        # Calculate the maximum twin sum
        max_sum = 0
        left = head
        right = prev
        while right:
            max_sum = max(max_sum, left.val + right.val)
            left = left.next
            right = right.next

        return max_sum