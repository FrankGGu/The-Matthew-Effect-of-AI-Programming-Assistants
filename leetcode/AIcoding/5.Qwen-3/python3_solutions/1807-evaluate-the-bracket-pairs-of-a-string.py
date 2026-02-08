class Solution:
    def evaluate(self, s: str, knowledge: List[List[str]]) -> str:
        stack = []
        current_key = None
        knowledge_dict = {k: v for k, v in knowledge}

        for char in s:
            if char == '{':
                current_key = ''
            elif char == '}':
                if current_key is not None:
                    stack.append(knowledge_dict.get(current_key, ''))
                    current_key = None
            elif current_key is not None:
                current_key += char
            else:
                stack.append(char)

        return ''.join(stack)