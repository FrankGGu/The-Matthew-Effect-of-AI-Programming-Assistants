class Solution:
    def verifyPreorder(self, preorder: str) -> bool:
        stack = []
        for node in preorder.split(','):
            while stack and stack[-1] == '#':
                stack.pop()
                if not stack:
                    return False
            stack.append(node)
        return True