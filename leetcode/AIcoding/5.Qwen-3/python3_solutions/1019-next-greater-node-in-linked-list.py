class Solution:
    def nextLargerNode(self, head: ListNode) -> List[int]:
        stack = []
        result = []
        index = 0
        current = head
        while current:
            result.append(0)
            while stack and current.val > stack[-1][0]:
                val, i = stack.pop()
                result[i] = current.val
            stack.append((current.val, index))
            current = current.next
            index += 1
        return result