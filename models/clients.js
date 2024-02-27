export let clients = [{
    "client_name": "Pepito",
    "client_age": "49",
    "client_email": "123abc@gmail.com"
},{
    "client_name": "josep",
    "client_age": "33",
    "client_email": "123abcde@gmail.com"
}
]

export function getClient(nom) {
    for (let client of clients) {
        if (client.client_name == nom)
            return { "status": "ok", "data": client }
    }
    return null;
}

export function addClientName(name) {
    clients.push({
      "client_name": name
    });
    return { "status": "ok", "message": "Client name added." };
  }
  
export function addClient(name, age, email) {
    clients.push({
        "client_name": name,
        "client_age": age,
        "client_email": email
    });
    return { "status": "ok", "message": "Client added." };
}