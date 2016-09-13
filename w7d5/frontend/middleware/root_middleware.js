import {applyMiddleware} from 'redux';
import BenchesMiddleware from './bench_middleware';
import SessionMiddleware from './session_middleware';

const RootMiddleware = applyMiddleware(
  BenchesMiddleware,
  SessionMiddleware
);

export default RootMiddleware;
