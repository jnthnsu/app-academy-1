import {TodoActions, receiveTodos, receiveTodo} from '../actions/todo_actions';
import {fetchTodos, createTodo} from '../util/todo_api_util';

export const TodoMiddleware = ({dispatch}) => next => action => {
  let success = todos => dispatch(receiveTodos(todos));
  let error = e => console.log(e.responseJSON);

  console.log(`todo: ${action.todo}`);
  switch (action.type) {
    case TodoActions.REQUEST_TODOS:
      fetchTodos(success, error);
      return next(action);
    case TodoActions.CREATE_TODO:
      success = todo => dispatch(receiveTodo(todo));
      createTodo(action.todo, success, error);
      return next(action);
    default:
      return next(action);
  }
};
