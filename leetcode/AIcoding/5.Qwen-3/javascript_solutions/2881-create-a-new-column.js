function createNewColumn(df) {
  df['country'] = df['city'].map(city => {
    if (city === 'Los Angeles' || city === 'San Francisco') {
      return 'USA';
    } else if (city === 'London' || city === 'Manchester') {
      return 'UK';
    } else {
      return 'Other';
    }
  });
  return df;
}