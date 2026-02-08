struct Solution;

impl Solution {
    pub fn reverse_pairs(nums: Vec<i32>) -> i32 {
        let mut temp = vec![0; nums.len()];
        Self::merge_sort(&mut nums, &mut temp, 0, nums.len() as i32 - 1)
    }

    fn merge_sort(nums: &mut Vec<i32>, temp: &mut Vec<i32>, left: i32, right: i32) -> i32 {
        if left >= right {
            return 0;
        }
        let mid = left + (right - left) / 2;
        let mut count = 0;
        count += Self::merge_sort(nums, temp, left, mid);
        count += Self::merge_sort(nums, temp, mid + 1, right);
        count += Self::merge(nums, temp, left, mid, right);
        count
    }

    fn merge(nums: &mut Vec<i32>, temp: &mut Vec<i32>, left: i32, mid: i32, right: i32) -> i32 {
        let mut i = left;
        let mut j = mid + 1;
        let mut k = left;
        let mut count = 0;

        while i <= mid && j <= right {
            if nums[i as usize] <= nums[j as usize] {
                temp[k as usize] = nums[i as usize];
                i += 1;
            } else {
                temp[k as usize] = nums[j as usize];
                count += (mid - i + 1) as i32;
                j += 1;
            }
            k += 1;
        }

        while i <= mid {
            temp[k as usize] = nums[i as usize];
            i += 1;
            k += 1;
        }

        while j <= right {
            temp[k as usize] = nums[j as usize];
            j += 1;
            k += 1;
        }

        for idx in left..=right {
            nums[idx as usize] = temp[idx as usize];
        }

        count
    }
}