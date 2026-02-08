class Solution:
    def topStudents(self, words: List[str], badges: List[int], n: int) -> List[str]:
        from collections import Counter

        word_count = Counter(words)
        badge_map = {word: badge for word, badge in zip(words, badges)}
        sorted_words = sorted(word_count.keys(), key=lambda x: (-word_count[x], -badge_map[x]))
        return sorted_words[:n]