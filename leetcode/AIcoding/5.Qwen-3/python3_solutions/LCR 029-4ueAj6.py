class Node:
    def __init__(self, val=None, next=None):
        self.val = val
        self.next = next

class Solution:
    def insert(self, head: 'Node', insertVal: int) -> 'Node':
        if head is None:
            node = Node(insertVal)
            node.next = node
            return node

        curr = head
        while True:
            if curr.val <= insertVal <= curr.next.val:
                break
            elif curr.next.val < curr.val and (insertVal < curr.next.val or insertVal > curr.val):
                break
            curr = curr.next

        new_node = Node(insertVal, curr.next)
        curr.next = new_node
        return head