import { addFruit, frutes, getFruit } from "../models/frutes.js";


export default class FruitsController {
    static ObtenirNomsController(req, res) {
        let lista = []
        let response;
        let type = "application/json";
        let status;
        if (typeof (req.params.nombre) === typeof (undefined) && typeof (req.query.nombre) === typeof (undefined)) {
            for (let fruta of frutes) { lista.push(fruta.fruit_name); }
            response = { "status": "ok", "data": lista };
            status = 200;
        } else {
            let nombre;
            if (typeof (req.params.nombre) !== typeof (undefined)) nombre = req.params.nombre;
            else nombre = req.query.nombre;

            response = getFruit(nombre)
            if (!response) response = { "status": "error", "msg": "Fruit not Found" };
        }
        res.type = type;
        res.status = status;
        res.send(response)
    }

    static ObtenirDadesFrutesPost(req, res) {

        let nom = req.body.nom || null;
        res.status = 200;
        let response = getFruit(nom);
        if (!response) response = { "status": "error", "msg": "Fruit not Found" };

        res.send(response);

    }

    static AfegirFrutes(req, res) {

        let fruit_name = req.body.fruit_name || null;
        let size = req.body.size || null;
        let color = req.body.color || null;
        let productor=req.body.major_producer || null;

        console.log(fruit_name);
        console.log(size);
        console.log(color)
        console.log(productor);

        let response;

        if (fruit_name && size && color) {
            addFruit(fruit_name, size, color, productor);
            response = { "status": "ok" }
        } else response = { "status": "error", "errorMsg": "Undefined Data" };

        res.send(response);

    }

    static DefaultController(req, res) {
        res.send('Error 404. Not Found');
    }
}
