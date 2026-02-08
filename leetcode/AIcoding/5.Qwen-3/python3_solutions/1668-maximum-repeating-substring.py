class Solution:
    def maxRepeating(self, sequence: str, word: str) -> int:
        count = 0
        temp = word
        while temp in sequence:
            count += 1
            temp += word
        return count