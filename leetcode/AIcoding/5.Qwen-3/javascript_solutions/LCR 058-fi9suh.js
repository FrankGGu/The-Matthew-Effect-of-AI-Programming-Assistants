var MyCalendar = function() {
    this.bookings = [];
};

MyCalendar.prototype.book = function(start, end) {
    for (let i = 0; i < this.bookings.length; i++) {
        let [s, e] = this.bookings[i];
        if (start < e && end > s) {
            return false;
        }
    }
    this.bookings.push([start, end]);
    return true;
};