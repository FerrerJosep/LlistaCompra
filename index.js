import express from 'express';

import FruitsController from './controllers/frutes_controller.js';
import {frutes, getFruit, addFruit} from './models/frutes.js';

// La biblioteca bodyParser es un módulo commonJS y no
// soporta import { urlencoded, json } from 'body-parser';
// Debemos hacerlo así
import bodyParser from 'body-parser';
import ClientsController from './controllers/client_controller.js';
const { urlencoded, json } = bodyParser;

// Definimos app como una aplicación express, utilizando el método 
// de factoría express().
const app = express();

//Creacio del router 
const router=express.Router();
const routerClient=express.Router();

// Definimos app como una aplicación express, utilizando el método 
// de factoría express().


// Configuramos la aplicación para que descodifique 
// las peticiones del cliente y las pase a JSON.
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Configuramos el servidor para escuchar por el puerto  8080
// Observad que el primer argumento es el puerto y el segundo
// es un callback que se lanza cuando se ha iniciado el servidor.
app.listen(8080, () => {
    console.log('Escuchando por el puerto 8080')
});

// Definimos el endpoint "/" para peticiones GET
// Observad que la función `get` requiere dos argumentos,
// el primero el "endpoint" y el segundo es un callback 
// que se invoca cuando se recibe una petición (req). En 
// esta función, en lugar de devolver un resultado con return
// lo que hacemos es enviarlo a través de la respuesta (res).
app.get('/', function (req, res) {
    res.send('Bienvenido al servidor');
});


app.get('/saludo', function (req, res) {
    res.send(`<html>
    <head>
        <title>Bienvenido al servidor</title>
    </head>
    <body>
        <h1>Hola! Bienvenido al servidor</h1>
    </body>
</html>`);
});

app.post('/api/frutes', function(req, res) {

    let nombre = req.body.nombre || null;

    res.status = 200;
    let response = getFruit(nombre);
    if (!response) response = { "status": "error", "msg": "frutes not Found" };

    res.send(response);

});

app.get("/llista", function(req, res){
    res.send("Llista frutes")
});

app.get("/info", function (req, res) {

    // Parámetros de la petición
    let metodo = req.method;
    let ruta = req.path;
    let host = req.get("host"); // Alias de req.header("host");

    // Configuración de la respuesta
    let tipo = "text/plain";
    let estado = 200;

    // Uso de template string para la salida
    let salida = 
    `Método: ${metodo} 
    Ruta: ${ruta}
    Host: ${host}
    `;

    res.type(tipo);
    res.status(estado);

    res.send(salida);
});

app.get("/echo/:texto", function (req, res) {
    res.send(req.params.texto);
});


//Configurar rutes del router
router.get('/:nombre?', FruitsController.ObtenirNomsController);
router.post('/', FruitsController.ObtenirDadesFrutesPost);
router.put('/', FruitsController.AfegirFrutes);
router.get('/', FruitsController.DefaultController)

//Ruta que ha de seguir sempre
app.use("/api/frutes", router);


routerClient.post('/', ClientsController.ObtenirDadesClientsPost);
routerClient.put('/', ClientsController.AfegirClient);
routerClient.get('/', ClientsController.DefaultController)

app.use("/api/clients", routerClient);

//Metode que cobreix totes les rutes, sempre al final
app.get('*', function (req, res) {
    console.log("Callback general");
    res.send(`Lo siento, no encuentro ${req.url}`);
});

