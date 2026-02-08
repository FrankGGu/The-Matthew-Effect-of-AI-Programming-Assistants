class Solution:
    def possible(self, nums, k):
        n = len(nums)
        visited = [False] * n
        for i in range(n):
            if visited[i]:
                continue
            j = i
            while not visited[j]:
                visited[j] = True
                j = nums[j]
                if j == i:
                    break
        return all(visited)

    def oddEvenIndex(self, nums):
        odd = []
        even = []
        for i in range(len(nums)):
            if i % 2 == 0:
                even.append(nums[i])
            else:
                odd.append(nums[i])
        return even + odd

    def makeLargestSpecial(self, s):
        count = 0
        start = 0
        res = []
        for i in range(len(s)):
            if s[i] == '1':
                count += 1
            else:
                count -= 1
            if count == 0:
                res.append(s[start:i+1])
                start = i + 1
        for i in range(len(res)):
            res[i] = self.makeLargestSpecial(res[i][1:-1])
        res.sort()
        return ''.join(res)

    def largestNumber(self, A):
        A = list(map(str, A))
        A.sort(key=lambda x: x*9)
        return ''.join(A) if A[0] != '0' else '0'

    def canBeEqual(self, target, arr):
        from collections import Counter
        return Counter(target) == Counter(arr)

    def smallestSubsequence(self, s, k, letter, repetition):
        from collections import Counter
        n = len(s)
        cnt = Counter(s)
        res = []
        for i in range(n):
            while res and res[-1] > s[i] and len(res) - 1 + n - i >= k and cnt[res[-1]] > 0:
                res.pop()
                cnt[res[-1]] += 1
            res.append(s[i])
            cnt[s[i]] -= 1
        return ''.join(res[:k])

    def findTheArrayConcValue(self, nums):
        n = len(nums)
        total = 0
        for i in range(n // 2):
            total += int(str(nums[i]) + str(nums[n - 1 - i]))
        return total

    def minOperations(self, nums):
        from collections import deque
        q = deque()
        q.append((nums, 0))
        visited = set()
        visited.add(tuple(nums))
        while q:
            curr, ops = q.popleft()
            if curr == sorted(curr):
                return ops
            for i in range(len(curr) - 1):
                if curr[i] > curr[i + 1]:
                    new_curr = curr[:]
                    new_curr[i], new_curr[i + 1] = new_curr[i + 1], new_curr[i]
                    if tuple(new_curr) not in visited:
                        visited.add(tuple(new_curr))
                        q.append((new_curr, ops + 1))
        return -1

    def getPermutation(self, n, k):
        from math import factorial
        nums = list(range(1, n + 1))
        k -= 1
        res = []
        while n > 0:
            fact = factorial(n - 1)
            index = k // fact
            res.append(str(nums[index]))
            nums.pop(index)
            k %= fact
            n -= 1
        return ''.join(res)

    def isPathCrossing(self, path):
        visited = set()
        x, y = 0, 0
        visited.add((x, y))
        for move in path:
            if move == 'N':
                y += 1
            elif move == 'S':
                y -= 1
            elif move == 'E':
                x += 1
            elif move == 'W':
                x -= 1
            if (x, y) in visited:
                return True
            visited.add((x, y))
        return False

    def maxDistance(self, grid):
        from collections import deque
        n = len(grid)
        q = deque()
        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    q.append((i, j))
        if len(q) == 0 or len(q) == n * n:
            return 0
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        max_dist = 0
        while q:
            x, y = q.popleft()
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < n and grid[nx][ny] == 0:
                    grid[nx][ny] = grid[x][y] + 1
                    max_dist = max(max_dist, grid[nx][ny] - 1)
                    q.append((nx, ny))
        return max_dist

    def maximumHappinessSum(self, happiness, k):
        happiness.sort(reverse=True)
        total = 0
        for i in range(k):
            if happiness[i] <= 0:
                break
            total += happiness[i] - i
        return total

    def minGroupsForValidAssignment(self, lattice):
        from collections import Counter
        cnt = Counter(lattice)
        min_val = min(cnt.values())
        max_val = max(cnt.values())
        for k in range(1, min_val + 1):
            if (max_val + k - 1) // k <= min_val:
                return k
        return min_val

    def minimumPushes(self, word):
        from collections import Counter
        cnt = Counter(word)
        pushes = 0
        for ch, freq in cnt.items():
            pushes += freq * ((ord(ch) - ord('a')) // 8 + 1)
        return pushes

    def largestMultipleOfThree(self, digits):
        from collections import Counter
        digits.sort(reverse=True)
        cnt = Counter(digits)
        total = sum(digits)
        if total % 3 == 0:
            return ''.join(map(str, digits)) if digits else '0'
        if total % 3 == 1:
            for i in range(len(digits) - 1, -1, -1):
                if digits[i] % 3 == 1:
                    del digits[i]
                    break
            if not digits:
                return '0'
            if sum(digits) % 3 == 0:
                return ''.join(map(str, digits))
            else:
                for i in range(len(digits) - 1, -1, -1):
                    if digits[i] % 3 == 2:
                        del digits[i]
                        break
        else:
            for i in range(len(digits) - 1, -1, -1):
                if digits[i] % 3 == 2:
                    del digits[i]
                    break
            if not digits:
                return '0'
            if sum(digits) % 3 == 0:
                return ''.join(map(str, digits))
            else:
                for i in range(len(digits) - 1, -1, -1):
                    if digits[i] % 3 == 1:
                        del digits[i]
                        break
        return ''.join(map(str, digits)) if digits else '0'

    def findKthNumber(self, n, k):
        def countSteps(n, a, b):
            steps = 0
            while a <= n:
                steps += min(n + 1, b) - a
                a *= 10
                b *= 10
            return steps
        result = 1
        k -= 1
        while k > 0:
            steps = countSteps(n, result, result + 1)
            if steps <= k:
                result += 1
                k -= steps
            else:
                result *= 10
                k -= 1
        return result

    def getWordsInReach(self, beginWord, endWord, wordList):
        from collections import deque
        wordSet = set(wordList)
        if endWord not in wordSet:
            return []
        queue = deque([(beginWord, 0)])
        visited = set([beginWord])
        while queue:
            word, level = queue.popleft()
            if word == endWord:
                return [word]
            for i in range(len(word)):
                for c in 'abcdefghijklmnopqrstuvwxyz':
                    next_word = word[:i] + c + word[i+1:]
                    if next_word in wordSet and next_word not in visited:
                        visited.add(next_word)
                        queue.append((next_word, level + 1))
        return []

    def findMinDifference(self, timePoints):
        from datetime import datetime
        times = [datetime.strptime(t, "%M:%S") for t in timePoints]
        times.sort()
        min_diff = float('inf')
        for i in range(1, len(times)):
            diff = (times[i] - times[i - 1]).total_seconds()
            min_diff = min(min_diff, diff)
        return int(min_diff)

    def numberOfPairs(self, skill):
        from collections import Counter
        cnt = Counter(skill)
        pairs = 0
        for v in cnt