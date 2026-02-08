class Solution:
    def splitMessage(self, message: str, limit: int) -> List[List[str]]:
        n = len(message)
        result = []
        i = 0
        while i < n:
            j = i + 1
            while j <= n:
                if len(str(j)) + len(message[i:j]) > limit:
                    break
                j += 1
            if j - i == 0:
                return []
            result.append([message[i:j]])
            i = j
        return result