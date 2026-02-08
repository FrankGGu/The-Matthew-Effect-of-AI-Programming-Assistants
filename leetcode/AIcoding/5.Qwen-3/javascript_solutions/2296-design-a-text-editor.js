var TextEditor = function() {
    this.leftStack = [];
    this.rightStack = [];
};

TextEditor.prototype.addText = function(text) {
    for (let c of text) {
        this.leftStack.push(c);
    }
};

TextEditor.prototype.deleteText = function(k) {
    let deleted = 0;
    while (deleted < k && this.leftStack.length > 0) {
        this.leftStack.pop();
        deleted++;
    }
    return deleted;
};

TextEditor.prototype.cursorLeft = function(k) {
    let moved = 0;
    while (moved < k && this.leftStack.length > 0) {
        this.rightStack.push(this.leftStack.pop());
        moved++;
    }
    return this.leftStack.length;
};

TextEditor.prototype.cursorRight = function(k) {
    let moved = 0;
    while (moved < k && this.rightStack.length > 0) {
        this.leftStack.push(this.rightStack.pop());
        moved++;
    }
    return this.leftStack.length;
};

TextEditor.prototype.getText = function() {
    return this.leftStack.join('');
};