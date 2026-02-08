class Solution:
    def kthDistinct(self, arr: List[str], k: int) -> str:
        count = {}
        for s in arr:
            count[s] = count.get(s, 0) + 1
        for s in arr:
            if count[s] == 1:
                k -= 1
                if k == 0:
                    return s
        return ""