class Solution:
    def detectCycle(self, head: ListNode) -> ListNode:
        if not head or not head.next:
            return None

        slow = head
        fast = head
        has_cycle = False

        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
            if slow == fast:
                has_cycle = True
                break

        if not has_cycle:
            return None

        slow = head
        while slow != fast:
            slow = slow.next
            fast = fast.next

        return slow