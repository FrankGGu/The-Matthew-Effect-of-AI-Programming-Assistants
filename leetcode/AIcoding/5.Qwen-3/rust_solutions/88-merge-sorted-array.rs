impl Solution {
    pub fn merge(nums1: &mut Vec<i32>, m: i32, nums2: &mut Vec<i32>, n: i32) {
        let mut i = m as usize - 1;
        let mut j = n as usize - 1;
        let mut k = (m + n) as usize - 1;

        while i >= 0 && j >= 0 {
            if nums1[i] > nums2[j] {
                nums1[k] = nums1[i];
                i -= 1;
            } else {
                nums1[k] = nums2[j];
                j -= 1;
            }
            k -= 1;
        }

        while i >= 0 {
            nums1[k] = nums1[i];
            i -= 1;
            k -= 1;
        }

        while j >= 0 {
            nums1[k] = nums2[j];
            j -= 1;
            k -= 1;
        }
    }
}