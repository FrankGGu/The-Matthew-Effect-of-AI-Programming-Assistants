class Solution:
    def splitListToParts(self, root: ListNode, k: int) -> List[ListNode]:
        # Calculate the length of the linked list
        length = 0
        current = root
        while current:
            length += 1
            current = current.next

        # Determine the size of each part
        part_size = length // k
        remainder = length % k

        result = []
        current = root

        for i in range(k):
            result.append(current)
            # Determine the number of nodes to take for this part
            size = part_size + (1 if i < remainder else 0)
            # Move current to the end of this part
            for _ in range(size - 1):
                if current:
                    current = current.next
            # Break the link
            if current:
                next_node = current.next
                current.next = None
                current = next_node

        return result