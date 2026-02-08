var countSegments = function(s) {
    return s.trim().split(' ').filter(Boolean).length;
};