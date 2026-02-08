function maxDistance(colors) {
    let left = 0;
    let right = colors.length - 1;
    let maxDist = 0;

    while (left < right) {
        if (colors[left] !== colors[right]) {
            maxDist = Math.max(maxDist, right - left);
            break;
        } else {
            if (colors[left] === colors[left + 1]) {
                left++;
            } else {
                right--;
            }
        }
    }

    left = 0;
    right = colors.length - 1;

    while (left < right) {
        if (colors[left] !== colors[right]) {
            maxDist = Math.max(maxDist, right - left);
            break;
        } else {
            if (colors[right] === colors[right - 1]) {
                right--;
            } else {
                left++;
            }
        }
    }

    return maxDist;
}