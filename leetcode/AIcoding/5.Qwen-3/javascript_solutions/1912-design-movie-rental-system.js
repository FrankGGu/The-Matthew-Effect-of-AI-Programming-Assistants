var MovieRentalSystem = function (n, entries) {
    const availableMovies = new Map();
    const rentedMovies = new Map();
    const movieToTheaters = new Map();

    for (const [movie, theater] of entries) {
        if (!availableMovies.has(movie)) {
            availableMovies.set(movie, new Set());
        }
        availableMovies.get(movie).add(theater);

        if (!movieToTheaters.has(movie)) {
            movieToTheaters.set(movie, new Set());
        }
        movieToTheaters.get(movie).add(theater);
    }

    this.rent = function (movie, theater) {
        if (availableMovies.has(movie) && availableMovies.get(movie).has(theater)) {
            availableMovies.get(movie).delete(theater);
            if (availableMovies.get(movie).size === 0) {
                availableMovies.delete(movie);
            }

            if (!rentedMovies.has(movie)) {
                rentedMovies.set(movie, new Set());
            }
            rentedMovies.get(movie).add(theater);
        }
    };

    this.drop = function (movie, theater) {
        if (rentedMovies.has(movie) && rentedMovies.get(movie).has(theater)) {
            rentedMovies.get(movie).delete(theater);
            if (rentedMovies.get(movie).size === 0) {
                rentedMovies.delete(movie);
            }

            if (!availableMovies.has(movie)) {
                availableMovies.set(movie, new Set());
            }
            availableMovies.get(movie).add(theater);
        }
    };

    this.report = function () {
        const result = [];
        for (const [movie, theaters] of movieToTheaters.entries()) {
            if (theaters.size > 0) {
                result.push([movie, Array.from(theaters)]);
            }
        }
        return result.sort((a, b) => a[0] - b[0]);
    };
};