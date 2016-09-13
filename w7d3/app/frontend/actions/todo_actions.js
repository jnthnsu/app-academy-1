export const TodoActions = {
  REQUEST_TODOS: 'REQUEST_TODOS',
  RECEIVE_TODOS: 'RECEIVE_TODOS',
  CREATE_TODO: 'CREATE_TODO',
  RECEIVE_TODO: 'RECEIVE_TODO'
};

export const requestTodos = () => ({
  type: TodoActions.REQUEST_TODOS
});

export const receiveTodos = todos => ({
  type: TodoActions.RECEIVE_TODOS,
  todos
});

export const createTodo = (todo) => ({
  type: TodoActions.CREATE_TODO,
  todo
});

export const receiveTodo = todo => ({
  type: TodoActions.RECEIVE_TODO,
  todo
});
