export const FilterActions = {
  UPDATE_BOUNDS: 'UPDATE_BOUNDS'
};

export const updateBounds = bounds => ({
  type: FilterActions.UPDATE_BOUNDS,
  bounds
});
