class Solution:
    def countRangeSum(self, nums, lower, upper):
        def merge_sort(sums, left, right):
            if left >= right:
                return 0
            mid = (left + right) // 2
            count = merge_sort(sums, left, mid) + merge_sort(sums, mid + 1, right)
            j = mid + 1
            k = mid + 1
            for i in range(left, mid + 1):
                while j <= right and sums[j] - sums[i] < lower:
                    j += 1
                while k <= right and sums[k] - sums[i] <= upper:
                    k += 1
                count += k - j
            temp = []
            i = left
            j = mid + 1
            while i <= mid and j <= right:
                if sums[i] <= sums[j]:
                    temp.append(sums[i])
                    i += 1
                else:
                    temp.append(sums[j])
                    j += 1
            while i <= mid:
                temp.append(sums[i])
                i += 1
            while j <= right:
                temp.append(sums[j])
                j += 1
            sums[left:right+1] = temp
            return count

        sums = [0]
        for num in nums:
            sums.append(sums[-1] + num)
        return merge_sort(sums, 0, len(sums) - 1)