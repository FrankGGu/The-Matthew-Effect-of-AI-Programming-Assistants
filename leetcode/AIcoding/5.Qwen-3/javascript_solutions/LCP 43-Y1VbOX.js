function trafficLight(query) {
    const light = {
        "red": "green",
        "green": "yellow",
        "yellow": "red"
    };
    return light[query];
}