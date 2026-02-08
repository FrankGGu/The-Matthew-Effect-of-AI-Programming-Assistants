function largestRectangleArea(heights) {
    let maxArea = 0;
    const stack = [];

    for (let i = 0; i <= heights.length; i++) {
        const currentHeight = i < heights.length ? heights[i] : -1;

        while (stack.length > 0 && heights[stack[stack.length - 1]] > currentHeight) {
            const height = heights[stack.pop()];
            const width = stack.length > 0 ? i - stack[stack.length - 1] - 1 : i;
            maxArea = Math.max(maxArea, height * width);
        }

        stack.push(i);
    }

    return maxArea;
}