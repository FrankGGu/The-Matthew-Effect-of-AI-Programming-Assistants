function rob(nums) {
    let prev = 0, curr = 0;
    for (let num of nums) {
        let temp = curr;
        curr = Math.max(curr, prev + num);
        prev = temp;
    }
    return curr;
}