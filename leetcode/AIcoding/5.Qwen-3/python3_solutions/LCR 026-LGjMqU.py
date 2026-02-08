class Solution:
    def reorderList(self, head: ListNode) -> None:
        if not head or not head.next:
            return

        # 快慢指针找中间节点
        slow, fast = head, head
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next

        # 反转后半部分链表
        prev, curr = None, slow
        while curr:
            next_node = curr.next
            curr.next = prev
            prev = curr
            curr = next_node

        # 合并两个链表
        first, second = head, prev
        while second.next:
            next_first = first.next
            next_second = second.next
            first.next = second
            second.next = next_first
            first = next_first
            second = next_second