export const fetchAllPokemon = (success, error) => {
  $.ajax({
    type: 'GET',
    url: '/api/pokemon',
    dataType: 'json',
    success,
    error
  });
};

export const fetchAPokemon = (id, success, error) => {
  $.ajax({
    type: 'GET',
    url: `/api/pokemon/${id}`,
    data: {id},
    dataType: 'json',
    success,
    error
  });
};
