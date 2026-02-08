function maximalRectangle(matrix) {
    if (matrix.length === 0 || matrix[0].length === 0) return 0;
    let maxArea = 0;
    let heights = new Array(matrix[0].length).fill(0);
    for (let i = 0; i < matrix.length; i++) {
        for (let j = 0; j < matrix[0].length; j++) {
            if (matrix[i][j] === '1') {
                heights[j]++;
            } else {
                heights[j] = 0;
            }
        }
        maxArea = Math.max(maxArea, largestRectangleArea(heights));
    }
    return maxArea;
}

function largestRectangleArea(heights) {
    let maxArea = 0;
    let stack = [];
    heights.push(0);
    for (let i = 0; i < heights.length; i++) {
        while (stack.length > 0 && heights[stack[stack.length - 1]] > heights[i]) {
            let h = heights[stack.pop()];
            let w = stack.length > 0 ? i - stack[stack.length - 1] - 1 : i;
            maxArea = Math.max(maxArea, h * w);
        }
        stack.push(i);
    }
    heights.pop();
    return maxArea;
}