class Solution:
    def swapNodes(self, head: ListNode, k: int) -> ListNode:
        # Find the k-th node from the start
        first = head
        for _ in range(k - 1):
            first = first.next

        # Find the k-th node from the end
        second = head
        curr = first
        while curr.next:
            curr = curr.next
            second = second.next

        # Swap values
        first.val, second.val = second.val, first.val

        return head