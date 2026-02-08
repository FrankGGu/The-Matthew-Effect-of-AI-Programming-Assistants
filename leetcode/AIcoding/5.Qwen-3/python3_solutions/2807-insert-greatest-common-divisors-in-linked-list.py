class Solution:
    def insertGreatestCommonDivisors(self, head: ListNode) -> ListNode:
        def gcd(a, b):
            while b:
                a, b = b, a % b
            return a

        current = head
        while current and current.next:
            g = gcd(current.val, current.next.val)
            new_node = ListNode(g)
            new_node.next = current.next
            current.next = new_node
            current = new_node.next
        return head