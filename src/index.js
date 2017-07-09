require('!style-loader!css-loader!sass-loader!../public/sass/material-kit.scss');
import { Main } from './Main.elm';



const app = Main.embed(document.getElementById('root'));
const storageKey = 'styled';

app.ports.save.subscribe(value => localStorage.setItem(storageKey, JSON.stringify(value)));
app.ports.doload.subscribe(() => app.ports.load.send(localStorage.getItem(storageKey) || ""));
