var Solution = function(radius, x_center, y_center) {
    this.radius = radius;
    this.x_center = x_center;
    this.y_center = y_center;
};

Solution.prototype.randPoint = function() {
    let angle = Math.random() * 2 * Math.PI;
    let r = Math.sqrt(Math.random()) * this.radius;
    return [
        this.x_center + r * Math.cos(angle),
        this.y_center + r * Math.sin(angle)
    ];
};