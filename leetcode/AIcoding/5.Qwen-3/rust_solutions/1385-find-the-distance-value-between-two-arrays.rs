struct Solution;

impl Solution {
    pub fn find_the_distance_value(mut arr1: Vec<i32>, mut arr2: Vec<i32>, distance: i32) -> i32 {
        arr1.sort_unstable();
        arr2.sort_unstable();

        let mut count = 0;

        for num in arr1 {
            let mut valid = true;
            for other in &arr2 {
                if (num - other).abs() <= distance {
                    valid = false;
                    break;
                }
            }
            if valid {
                count += 1;
            }
        }

        count
    }
}