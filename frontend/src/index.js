import React from 'react';
import ReactDOM from 'react-dom';
import {BrowserRouter as Router, Route, Routes} from 'react-router-dom';
import './index.css';
import * as serviceWorker from './serviceWorker';
import Test from "./components/Test";
import Home from "./components/Home";
import ProductList from "./components/ProductList";

ReactDOM.render(
    <Router>
        <Routes>
            <Route exact path="/" element={<Home/>}/>
            <Route path="/test" element={<Test/>}/>
            <Route path="/list" element={<ProductList/>}/>
        </Routes>
    </Router>,
    document.getElementById('root'));

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
