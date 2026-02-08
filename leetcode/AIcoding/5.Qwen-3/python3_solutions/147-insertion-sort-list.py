class Solution:
    def insertionSortList(self, head: ListNode) -> ListNode:
        dummy = ListNode(0)
        curr = head
        while curr:
            prev = dummy
            while prev.next and prev.next.val < curr.val:
                prev = prev.next
            temp = curr.next
            curr.next = prev.next
            prev.next = curr
            curr = temp
        return dummy.next