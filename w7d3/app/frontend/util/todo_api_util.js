export const fetchTodos = (success, error) => (
  $.ajax({
    method: 'GET',
    url: 'api/todos',
    dataType: 'json',
    success,
    error
  })
);

export const createTodo = (todo, success, error) => (
  $.ajax({
    method: 'POST',
    url: 'api/todos',
    data: todo,
    dataType: 'json',
    success,
    error
  })
);
