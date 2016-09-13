export const ToyActions = {
  FETCH_TOY: 'FETCH_TOY'
};

export const fetchToy = id => ({
  type: ToyActions.FETCH_TOY,
  id
});
