class Solution:
    def trainingPlan(self, head: ListNode, cnt: int) -> ListNode:
        fast = head
        slow = head
        for _ in range(cnt):
            fast = fast.next
        while fast:
            fast = fast.next
            slow = slow.next
        return slow