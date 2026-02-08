class Solution:
    def numberOfMatchingSubarrays(self, nums: List[int], pattern: List[int]) -> int:
        from collections import defaultdict

        def buildTransitionMap(pattern):
            transition = defaultdict(list)
            for i in range(len(pattern)):
                transition[pattern[i]].append(i + 1)
            return transition

        def kmpFailureFunction(pattern):
            m = len(pattern)
            fail = [0] * m
            j = 0
            for i in range(1, m):
                while j > 0 and pattern[i] != pattern[j]:
                    j = fail[j - 1]
                if pattern[i] == pattern[j]:
                    j += 1
                    fail[i] = j
                else:
                    fail[i] = 0
            return fail

        def kmpSearch(text, pattern, fail):
            n = len(text)
            m = len(pattern)
            j = 0
            count = 0
            for i in range(n):
                while j > 0 and text[i] != pattern[j]:
                    j = fail[j - 1]
                if text[i] == pattern[j]:
                    j += 1
                if j == m:
                    count += 1
                    j = fail[j - 1]
            return count

        m = len(pattern)
        if m == 0:
            return 0

        transition = buildTransitionMap(pattern)
        fail = kmpFailureFunction(pattern)

        text = []
        for i in range(1, len(nums)):
            if nums[i] > nums[i - 1]:
                text.append(1)
            elif nums[i] < nums[i - 1]:
                text.append(-1)
            else:
                text.append(0)

        return kmpSearch(text, pattern, fail)