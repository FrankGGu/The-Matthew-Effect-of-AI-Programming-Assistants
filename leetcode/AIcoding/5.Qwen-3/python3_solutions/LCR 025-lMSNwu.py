class Solution:
    def addTwoNumbers(self, l1: ListNode, l2: ListNode) -> ListNode:
        def reverseList(head):
            prev = None
            curr = head
            while curr:
                next_node = curr.next
                curr.next = prev
                prev = curr
                curr = next_node
            return prev

        def listToNum(head):
            num = 0
            while head:
                num = num * 10 + head.val
                head = head.next
            return num

        def numToList(num):
            if num == 0:
                return ListNode(0)
            dummy = ListNode(0)
            curr = dummy
            while num > 0:
                curr.next = ListNode(num % 10)
                num = num // 10
                curr = curr.next
            return dummy.next

        l1 = reverseList(l1)
        l2 = reverseList(l2)
        num1 = listToNum(l1)
        num2 = listToNum(l2)
        sum_num = num1 + num2
        return numToList(sum_num)