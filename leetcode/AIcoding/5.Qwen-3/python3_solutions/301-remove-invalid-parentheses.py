from typing import List
import collections

class Solution:
    def removeInvalidParentheses(self, s: str) -> List[str]:
        def is_valid(string):
            count = 0
            for char in string:
                if char == '(':
                    count += 1
                elif char == ')':
                    count -= 1
                    if count < 0:
                        return False
            return count == 0

        result = []
        visited = set()
        queue = collections.deque([s])
        visited.add(s)
        found = False

        while queue:
            level_size = len(queue)
            for _ in range(level_size):
                current = queue.popleft()
                if is_valid(current):
                    result.append(current)
                    found = True
                if found:
                    continue
                for i in range(len(current)):
                    if current[i] in '()':
                        new_str = current[:i] + current[i+1:]
                        if new_str not in visited:
                            visited.add(new_str)
                            queue.append(new_str)
            if found:
                break

        return result