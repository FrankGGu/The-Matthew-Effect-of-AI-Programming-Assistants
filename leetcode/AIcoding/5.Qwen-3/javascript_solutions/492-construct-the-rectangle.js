function constructRectangle(area) {
    for (let i = Math.sqrt(area); i >= 1; i--) {
        if (area % i === 0) {
            return [Math.floor(area / i), Math.floor(i)];
        }
    }
}