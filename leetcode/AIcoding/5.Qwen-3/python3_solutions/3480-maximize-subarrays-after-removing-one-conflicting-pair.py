class Solution:
    def removeOne(self, s: str) -> int:
        def maxSubarrays(s: str) -> int:
            count = 0
            balance = 0
            for c in s:
                if c == '(':
                    balance += 1
                else:
                    balance -= 1
                if balance == 0:
                    count += 1
            return count

        n = len(s)
        max_result = 0
        for i in range(n):
            if s[i] == ')':
                left = s[:i]
                right = s[i+1:]
                left_balance = 0
                left_count = 0
                for c in left:
                    if c == '(':
                        left_balance += 1
                    else:
                        left_balance -= 1
                    if left_balance == 0:
                        left_count += 1
                right_balance = 0
                right_count = 0
                for c in right:
                    if c == '(':
                        right_balance += 1
                    else:
                        right_balance -= 1
                    if right_balance == 0:
                        right_count += 1
                max_result = max(max_result, left_count + right_count)
        return max_result