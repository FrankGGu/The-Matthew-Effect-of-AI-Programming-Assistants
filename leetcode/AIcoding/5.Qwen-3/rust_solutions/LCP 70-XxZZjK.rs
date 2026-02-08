struct Solution;

impl Solution {
    pub fn is_possible_to_get_array_goal(arr: Vec<i32>, target: Vec<i32>) -> bool {
        let mut arr = arr;
        let mut target = target;
        arr.sort();
        target.sort();
        arr == target
    }
}