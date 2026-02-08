class Solution:
    def isItPossible(self, s: str, t: str) -> bool:
        from collections import Counter

        count_s = Counter(s)
        count_t = Counter(t)

        for char_s in count_s:
            for char_t in count_t:
                if char_s == char_t:
                    continue
                new_count_s = count_s.copy()
                new_count_t = count_t.copy()
                new_count_s[char_s] -= 1
                new_count_t[char_t] -= 1
                if new_count_s[char_s] == 0:
                    del new_count_s[char_s]
                if new_count_t[char_t] == 0:
                    del new_count_t[char_t]
                new_count_s[char_t] = new_count_s.get(char_t, 0) + 1
                new_count_t[char_s] = new_count_t.get(char_s, 0) + 1
                if len(new_count_s) == len(new_count_t):
                    return True
        return False