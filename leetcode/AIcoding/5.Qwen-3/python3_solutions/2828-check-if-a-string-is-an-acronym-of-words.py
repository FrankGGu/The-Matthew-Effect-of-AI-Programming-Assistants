class Solution:
    def isAcronym(self, words, acronym):
        if len(words) != len(acronym):
            return False
        for i in range(len(words)):
            if words[i][0] != acronym[i]:
                return False
        return True