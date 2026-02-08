class Solution:
    def entityParser(self, text: str) -> str:
        entity_map = {
            "&quot;": '"',
            "&apos;": "'",
            "&amp;": "&",
            "&lt;": "<",
            "&gt;": ">",
            "&frasl;": "/"
        }
        result = []
        i = 0
        while i < len(text):
            if text[i] == '&':
                for j in range(i + 1, min(i + 7, len(text) + 1)):
                    if text[j] == ';':
                        entity = text[i:j+1]
                        if entity in entity_map:
                            result.append(entity_map[entity])
                        else:
                            result.append(entity)
                        i = j + 1
                        break
                else:
                    result.append(text[i])
                    i += 1
            else:
                result.append(text[i])
                i += 1
        return ''.join(result)