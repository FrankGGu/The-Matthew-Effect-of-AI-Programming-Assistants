class Solution:
    def cut竹子(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        from collections import defaultdict
        import heapq

        def get_min(nums):
            return min(nums)

        def get_max(nums):
            return max(nums)

        def get_sum(nums):
            return sum(nums)

        def get_kth(nums, k):
            return sorted(nums)[k-1]

        def get_avg(nums):
            return sum(nums) / len(nums)

        def get_median(nums):
            return sorted(nums)[len(nums)//2]

        def get_mode(nums):
            count = defaultdict(int)
            for num in nums:
                count[num] += 1
            max_freq = max(count.values())
            for num, freq in count.items():
                if freq == max_freq:
                    return num

        def get_range(nums):
            return max(nums) - min(nums)

        def get_variance(nums):
            avg = get_avg(nums)
            return sum((x - avg)**2 for x in nums) / len(nums)

        def get_std_dev(nums):
            return get_variance(nums)**0.5

        def get_percentile(nums, p):
            nums_sorted = sorted(nums)
            index = int(len(nums_sorted) * p / 100)
            return nums_sorted[index]

        def get_iqr(nums):
            nums_sorted = sorted(nums)
            q1 = nums_sorted[len(nums_sorted)//4]
            q3 = nums_sorted[3*len(nums_sorted)//4]
            return q3 - q1

        def get_skewness(nums):
            avg = get_avg(nums)
            std_dev = get_std_dev(nums)
            return sum((x - avg)**3 for x in nums) / (len(nums) * std_dev**3)

        def get_kurtosis(nums):
            avg = get_avg(nums)
            std_dev = get_std_dev(nums)
            return sum((x - avg)**4 for x in nums) / (len(nums) * std_dev**4) - 3

        result = []
        for query in queries:
            if query[0] == 1:
                result.append(get_min(nums))
            elif query[0] == 2:
                result.append(get_max(nums))
            elif query[0] == 3:
                result.append(get_sum(nums))
            elif query[0] == 4:
                result.append(get_kth(nums, query[1]))
            elif query[0] == 5:
                result.append(get_avg(nums))
            elif query[0] == 6:
                result.append(get_median(nums))
            elif query[0] == 7:
                result.append(get_mode(nums))
            elif query[0] == 8:
                result.append(get_range(nums))
            elif query[0] == 9:
                result.append(get_variance(nums))
            elif query[0] == 10:
                result.append(get_std_dev(nums))
            elif query[0] == 11:
                result.append(get_percentile(nums, query[1]))
            elif query[0] == 12:
                result.append(get_iqr(nums))
            elif query[0] == 13:
                result.append(get_skewness(nums))
            elif query[0] == 14:
                result.append(get_kurtosis(nums))
        return result