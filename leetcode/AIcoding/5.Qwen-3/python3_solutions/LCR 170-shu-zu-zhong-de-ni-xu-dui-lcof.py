class Solution:
    def reversePairs(self, nums):
        def merge_sort(arr, left, right):
            if left >= right:
                return 0
            mid = (left + right) // 2
            count = merge_sort(arr, left, mid) + merge_sort(arr, mid + 1, right)
            i, j, k = left, mid + 1, left
            temp = []
            while i <= mid and j <= right:
                if arr[i] <= arr[j]:
                    temp.append(arr[i])
                    i += 1
                else:
                    temp.append(arr[j])
                    j += 1
                    count += mid - i + 1
            while i <= mid:
                temp.append(arr[i])
                i += 1
            while j <= right:
                temp.append(arr[j])
                j += 1
            for num in temp:
                arr[k] = num
                k += 1
            return count

        return merge_sort(nums, 0, len(nums) - 1)