import React from 'react';
import ReactDOM from 'react-dom/client';
import { Provider } from 'react-redux';
import { createStore } from 'redux';
import rootReducer from './Redux/Reducer';
import App from './App';
import reportWebVitals from './reportWebVitals';

// Crea el store de Redux
const store = createStore(rootReducer);

// Crea el elemento raíz y renderiza la aplicación
const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>
);

// Reporta las métricas web (opcional)
reportWebVitals();
