function renameColumns(df) {
    return df.rename(columns => {
        const newColumns = {};
        for (let i = 0; i < columns.length; i++) {
            newColumns[columns[i]] = "col" + (i + 1);
        }
        return newColumns;
    });
}