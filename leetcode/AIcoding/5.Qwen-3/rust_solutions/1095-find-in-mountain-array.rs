struct Solution;

trait MountainArray {
    fn get(&self, index: i32) -> i32;
    fn length(&self) -> i32;
}

impl Solution {
    pub fn find_in_mountain_array(target: i32, mountain_arr: &dyn MountainArray) -> i32 {
        let n = mountain_arr.length();
        let mut left = 0;
        let mut right = n - 1;
        let mut peak = 0;

        // Find the peak of the mountain array
        while left < right {
            let mid = (left + right) / 2;
            if mountain_arr.get(mid) < mountain_arr.get(mid + 1) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        peak = left;

        // Search in the increasing part
        left = 0;
        right = peak;
        while left <= right {
            let mid = (left + right) / 2;
            let val = mountain_arr.get(mid);
            if val == target {
                return mid;
            } else if val < target {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        // Search in the decreasing part
        left = peak;
        right = n - 1;
        while left <= right {
            let mid = (left + right) / 2;
            let val = mountain_arr.get(mid);
            if val == target {
                return mid;
            } else if val < target {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        -1
    }
}