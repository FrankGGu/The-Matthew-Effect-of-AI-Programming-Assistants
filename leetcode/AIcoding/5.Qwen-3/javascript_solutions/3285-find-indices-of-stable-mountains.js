function stableMountains(height) {
    const result = [];
    for (let i = 1; i < height.length - 1; i++) {
        if (height[i] > height[i - 1] && height[i] > height[i + 1]) {
            result.push(i);
        }
    }
    return result;
}