class Solution:
    def removeZeroSumSublists(self, head: ListNode) -> ListNode:
        dummy = ListNode(0)
        dummy.next = head
        prefix_sum = 0
        sum_map = {}
        current = dummy
        while current:
            prefix_sum += current.val
            if prefix_sum in sum_map:
                prev = sum_map[prefix_sum]
                prev.next = current.next
            else:
                sum_map[prefix_sum] = current
            current = current.next
        return dummy.next