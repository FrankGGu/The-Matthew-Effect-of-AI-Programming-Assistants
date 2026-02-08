class Solution:
    def largestWordCount(self, messages: List[str], names: List[str]) -> str:
        from collections import defaultdict

        count = defaultdict(int)
        max_count = -1
        result = ""

        for i in range(len(messages)):
            words = len(messages[i].split())
            count[names[i]] += words

        for name in count:
            if count[name] > max_count:
                max_count = count[name]
                result = name
            elif count[name] == max_count and name < result:
                result = name

        return result