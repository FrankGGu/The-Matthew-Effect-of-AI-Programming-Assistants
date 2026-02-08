class Solution:
    def findReplaceString(self, s: str, indices: list[int], sources: list[str], targets: list[str]) -> str:
        result = []
        i = 0
        while i < len(s):
            if i in indices:
                idx = indices.index(i)
                if s.startswith(sources[idx], i):
                    result.append(targets[idx])
                    i += len(sources[idx])
                else:
                    result.append(s[i])
                    i += 1
            else:
                result.append(s[i])
                i += 1
        return ''.join(result)