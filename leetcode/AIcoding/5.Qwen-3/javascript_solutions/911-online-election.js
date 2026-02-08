var Election = function(people, times) {
    this.people = people;
    this.times = times;
    this.counts = {};
    this.maxVotes = 0;
    this.currentWinner = '';

    for (let i = 0; i < times.length; i++) {
        const person = people[i];
        this.counts[person] = (this.counts[person] || 0) + 1;
        if (this.counts[person] > this.maxVotes) {
            this.maxVotes = this.counts[person];
            this.currentWinner = person;
        } else if (this.counts[person] === this.maxVotes) {
            this.currentWinner = Math.min(this.currentWinner, person);
        }
    }
};

Election.prototype.q = function(t) {
    let left = 0;
    let right = this.times.length - 1;
    let res = 0;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (this.times[mid] <= t) {
            res = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return this.people[res];
};