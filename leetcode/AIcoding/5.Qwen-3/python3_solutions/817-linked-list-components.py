class Solution:
    def numComponents(self, head: ListNode, nums: List[int]) -> int:
        nums_set = set(nums)
        result = 0
        current = head
        while current:
            if current.val in nums_set and (current.next is None or current.next.val not in nums_set):
                result += 1
            current = current.next
        return result