export const requestBenches = (filters, success, error) => {
  $.get({
    url: 'api/benches',
    data: {bounds: filters.bounds},
    success,
    error
  });
};

export const createBench = (data, success, error) => {
  $.post({
    url: 'api/benches',
    data: data,
    success,
    error
  });
};
