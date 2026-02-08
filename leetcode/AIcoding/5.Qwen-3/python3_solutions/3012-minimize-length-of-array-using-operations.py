class Solution:
    def minFinalArraySize(self, nums: List[int], k: int) -> int:
        from collections import Counter

        count = Counter(nums)
        keys = list(count.keys())
        keys.sort()

        for i in range(len(keys)):
            if k <= 0:
                break
            while k > 0 and count[keys[i]] > 1:
                count[keys[i]] -= 1
                k -= 1
                if keys[i] + 1 in count:
                    count[keys[i] + 1] += 1
                else:
                    count[keys[i] + 1] = 1
                if keys[i] - 1 in count:
                    count[keys[i] - 1] += 1
                else:
                    count[keys[i] - 1] = 1
                del count[keys[i]]
                keys = list(count.keys())
                keys.sort()
                break

        return len(count)