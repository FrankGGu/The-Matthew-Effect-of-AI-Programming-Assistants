class Solution:
    def nodesBetweenCriticalPoints(self, head: ListNode) -> List[int]:
        if not head or not head.next or not head.next.next:
            return [-1, -1]

        critical_indices = []
        prev = head
        curr = head.next
        index = 1

        while curr.next:
            if (curr.val > prev.val and curr.val > curr.next.val) or (curr.val < prev.val and curr.val < curr.next.val):
                critical_indices.append(index)
            prev = curr
            curr = curr.next
            index += 1

        if len(critical_indices) < 2:
            return [-1, -1]

        min_dist = float('inf')
        max_dist = critical_indices[-1] - critical_indices[0]

        for i in range(1, len(critical_indices)):
            min_dist = min(min_dist, critical_indices[i] - critical_indices[i-1])

        return [min_dist, max_dist]