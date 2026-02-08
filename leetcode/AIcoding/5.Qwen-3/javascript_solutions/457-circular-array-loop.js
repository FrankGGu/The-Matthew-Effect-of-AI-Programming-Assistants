function isCircularArrayLoop(nums) {
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        if (nums[i] === 0) continue;
        let direction = nums[i] > 0 ? 1 : -1;
        let slow = i, fast = i;
        while (true) {
            slow = nextIndex(nums, slow, direction);
            if (slow === -1) break;
            fast = nextIndex(nums, fast, direction);
            if (fast === -1) break;
            fast = nextIndex(nums, fast, direction);
            if (fast === -1) break;
            if (slow === fast) {
                if (slow === nextIndex(nums, slow, direction)) break;
                return true;
            }
        }
        let current = i;
        while (true) {
            let next = nextIndex(nums, current, direction);
            if (next === -1 || nums[current] === 0) break;
            nums[current] = 0;
            current = next;
        }
    }
    return false;
}

function nextIndex(nums, index, direction) {
    const n = nums.length;
    const next = index + nums[index];
    if (next < 0 || next >= n) return -1;
    if ((nums[next] > 0 && direction < 0) || (nums[next] < 0 && direction > 0)) return -1;
    return next;
}