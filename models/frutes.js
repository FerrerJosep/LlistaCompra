export let frutes = [{
    "fruit_name": "Apple",
    "size": "Large",
    "color": "Red"
}, {
    "fruit_name": "Banana",
    "size": "Medium",
    "color": "Yellow"
},
{
    "fruit_name": "Orange",
    "size": "Medium",
    "color": "Orange"
},
{
    "fruit_name": "Grapes",
    "size": "Small",
    "color": "Green"
},
{
    "fruit_name": "Strawberry",
    "size": "Small",
    "color": "Red"
},
{
    "fruit_name": "Pineapple",
    "size": "Large",
    "color": "Yellow"
},
{
    "fruit_name": "Watermelon",
    "size": "Large",
    "color": "Green"
},
{
    "fruit_name": "Peach",
    "size": "Medium",
    "color": "Orange"
},
{
    "fruit_name": "Pear",
    "size": "Medium",
    "color": "Yellow"
},
{
    "fruit_name": "Plum",
    "size": "Small",
    "color": "Purple"
}
]

export function getFruit(nom) {
    for (let fruit of frutes) {
        if (fruit.fruit_name === nom)
            return { "status": "ok", "data": fruit };
    }
    return null;
}

export function addFruit(fruit_name, size, color) {
    frutes.push({
        "fruit_name": fruit_name,
        "size": size,
        "color": color
    });
    return { "status": "ok", "message": "Fruta afegida." };
}

