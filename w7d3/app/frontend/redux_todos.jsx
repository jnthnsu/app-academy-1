import React from 'react';
import ReactDOM from 'react-dom';
import { fetchTodos } from './util/todo_api_util';
import { configureStore } from './store/store';
import { requestTodos, createTodo } from './actions/todo_actions';
import { Root } from './components/root';

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  const store = configureStore();
  window.createTodo = createTodo;
  window.store = store;
  ReactDOM.render(<Root store={store}/>, root);
});

window.requestTodos = requestTodos;
