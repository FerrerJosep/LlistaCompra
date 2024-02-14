export let clients = [{
    "client_name": "Pepito",
    "client_age": "49",
    "client_email": "123abc@gmail.com"
}
]

export function getClient(nom) {
    for (let client of clients) {
        if (client.client_name == nom)
            return { "status": "ok", "data": fruit }
    }
    return null;
}


export function addClient(name, age, email) {
    frutes.push({
        "client_name": name,
        "client_age": age,
        "client_email": email
    });
    return { "status": "ok", "message": "Client added." };
}