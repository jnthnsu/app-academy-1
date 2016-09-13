export const BenchActions = {
  RECEIVE_BENCHES: 'RECEIVE_BENCHES',
  REQUEST_BENCHES: 'REQUEST_BENCHES',
  CREATE_BENCH: 'CREATE_BENCH',
  RECEIVE_BENCH: 'RECEIVE_BENCH'
};

export const requestBenches = () => ({
  type: BenchActions.REQUEST_BENCHES,
});

export const receiveBenches = benches => ({
  type: BenchActions.RECEIVE_BENCHES,
  benches
});

export const createBench = bench => ({
  type: BenchActions.CREATE_BENCH,
  bench
});

export const receiveBench = bench => ({
  type: BenchActions.RECEIVE_BENCH,
  bench
});
