var floodFill = function(image, sr, sc, newColor) {
    const originalColor = image[sr][sc];
    if (originalColor === newColor) return image;

    const queue = [[sr, sc]];
    image[sr][sc] = newColor;

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    while (queue.length > 0) {
        const [r, c] = queue.shift();
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;
            if (nr >= 0 && nr < image.length && nc >= 0 && nc < image[0].length && image[nr][nc] === originalColor) {
                image[nr][nc] = newColor;
                queue.push([nr, nc]);
            }
        }
    }

    return image;
};