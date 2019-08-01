import { Elm } from './Main.elm';

const storageKey = "store";
const flags = localStorage.getItem(storageKey);
const app = Elm.Main.init({
    node: document.getElementById('root'),
    flags: flags
});
app.ports.storeCache.subscribe(val => {
    if (val === null) {
        localStorage.removeItem(storageKey);
    } else {
        localStorage.setItem(storageKey, JSON.stringify(val));
    }

    setTimeout(function () {
        app.ports.onStoreChange.send(val);
    }, 0);
});
window.addEventListener("storage", event => {
    if (event.storageArea === localStorage && event.key === storageKey) {
        app.ports.onStoreChange.send(event.newValue);
    }
}, false);