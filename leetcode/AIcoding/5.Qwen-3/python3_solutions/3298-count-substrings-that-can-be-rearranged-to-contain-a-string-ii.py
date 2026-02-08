class Solution:
    def isSubstringAvailable(self, s: str, t: str) -> bool:
        from collections import Counter
        count_t = Counter(t)
        count_s = Counter()
        left = 0
        for right in range(len(s)):
            count_s[s[right]] += 1
            while right - left + 1 > len(t):
                count_s[s[left]] -= 1
                if count_s[s[left]] == 0:
                    del count_s[s[left]]
                left += 1
            if count_s == count_t:
                return True
        return False

    def numberOfSubstrings(self, s: str, k: int, letters: List[str]) -> int:
        from collections import defaultdict
        count = defaultdict(int)
        left = 0
        result = 0
        for right in range(len(s)):
            count[s[right]] += 1
            while len(count) > len(letters):
                count[s[left]] -= 1
                if count[s[left]] == 0:
                    del count[s[left]]
                left += 1
            if len(count) == len(letters):
                result += left + 1
        return result