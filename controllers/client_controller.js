import { clients, getClient, addClient } from "../models/clients.js";


export default class ClientsController {
    static AfegirClient(req, res) {
        let client_name = req.body.client_name || null;
        let client_age = req.body.client_age || null;
        let client_email = req.body.client_email || null;

        let response;

        if (client_name && client_email) {
            addClient(client_name, client_age, client_email);
            response = { "status": "ok" }
        } else response = { "status": "error", "errorMsg": "Undefined Data" };

        res.send(response);


    }
    static ObtenirNomsClientController(req, res) {
        let lista = []
        let response;
        let type = "application/json";
        let status;
        if (typeof (req.params.nombre) === typeof (undefined) && typeof (req.query.nombre) === typeof (undefined)) {
            for (let client of clients) { lista.push(client.client_name); }
            response = { "status": "ok", "data": lista };
            status = 200;
        } else {
            let nombre;
            if (typeof (req.params.nombre) !== typeof (undefined)) nombre = req.params.nombre;
            else nombre = req.query.nombre;

            response = getClient(nombre)
            if (!response) response = { "status": "error", "msg": "Client not Found" };
        }
        res.type = type;
        res.status = status;
        res.send(response)
    }

    static ObtenirDadesClientsPost(req, res) {

        let nom = req.body.nom || null;
        res.status = 200;
        let response = getClient(nom);
        if (!response) response = { "status": "error", "msg": "Client not Found" };

        res.send(response);

    }
    static DefaultController(req, res) {
        res.send('Controlador Genèric');
    }
}
