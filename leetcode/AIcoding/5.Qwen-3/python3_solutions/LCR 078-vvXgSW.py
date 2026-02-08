import heapq

class Solution:
    def mergeKLists(self, lists: List[ListNode]) -> ListNode:
        heap = []
        for l in lists:
            if l:
                heapq.heappush(heap, (l.val, l))
        dummy = ListNode(0)
        curr = dummy
        while heap:
            val, node = heapq.heappop(heap)
            curr.next = ListNode(val)
            curr = curr.next
            if node.next:
                heapq.heappush(heap, (node.next.val, node.next))
        return dummy.next