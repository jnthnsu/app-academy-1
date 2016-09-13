export const allTodos = state => {

  return Object.keys(state.todos).map(key => state.todos[key]);
};
