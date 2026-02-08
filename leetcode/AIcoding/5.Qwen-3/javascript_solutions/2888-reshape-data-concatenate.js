function concatenateData(df, colName) {
    return df.map(row => ({
        ...row,
        [colName]: row[colName] + row[colName]
    }));
}