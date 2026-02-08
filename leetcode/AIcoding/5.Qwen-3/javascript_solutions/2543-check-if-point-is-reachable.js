function isReachable(targetX, targetY) {
    while (targetX > 0 && targetY > 0) {
        if (targetX === 1 && targetY === 1) return true;
        if (targetX % 2 === 0 && targetY % 2 === 0) {
            targetX /= 2;
            targetY /= 2;
        } else if (targetX % 2 === 0) {
            targetX /= 2;
        } else if (targetY % 2 === 0) {
            targetY /= 2;
        } else {
            break;
        }
    }
    return targetX === 1 && targetY === 1;
}