function Router() {
    this.routes = {};
}

Router.prototype.route = function(path, handler) {
    const parts = path.split('/').filter(p => p !== '');
    let current = this.routes;
    for (let i = 0; i < parts.length; i++) {
        const part = parts[i];
        if (!current[part]) {
            current[part] = {};
        }
        current = current[part];
    }
    current.handler = handler;
};

Router.prototype.dispatch = function(path) {
    const parts = path.split('/').filter(p => p !== '');
    let current = this.routes;
    let params = {};
    for (let i = 0; i < parts.length; i++) {
        const part = parts[i];
        if (current[part]) {
            current = current[part];
        } else if (current['*']) {
            const paramKey = current['*'].param;
            params[paramKey] = parts.slice(i).join('/');
            return current['*'].handler(params);
        } else {
            return null;
        }
    }
    return current.handler ? current.handler(params) : null;
};