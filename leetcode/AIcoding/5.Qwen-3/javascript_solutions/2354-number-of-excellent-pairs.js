function maximizeGreatness(nums) {
    const count = new Array(100001).fill(0);
    for (const num of nums) {
        count[num]++;
    }
    let great = 0;
    for (let i = 0; i <= 100000; i++) {
        if (count[i] > 0) {
            great += Math.min(count[i], count[i + 1]);
        }
    }
    return great;
}