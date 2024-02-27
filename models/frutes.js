export let frutes = [{
    "fruit_name": "Apple",
    "size": "Large",
    "color": "Red",
    "major_producer": "China"
}, {
    "fruit_name": "Banana",
    "size": "Medium",
    "color": "Yellow",
    "major_producer": "India"
},
{
    "fruit_name": "Orange",
    "size": "Medium",
    "color": "Orange",
    "major_producer": "Brazil"
},
{
    "fruit_name": "Grapes",
    "size": "Small",
    "color": "Green",
    "major_producer": "Italy"
},
{
    "fruit_name": "Strawberry",
    "size": "Small",
    "color": "Red",
    "major_producer": "United States"
},
{
    "fruit_name": "Pineapple",
    "size": "Large",
    "color": "Yellow",
    "major_producer": "Costa Rica"
},
{
    "fruit_name": "Watermelon",
    "size": "Large",
    "color": "Green",
    "major_producer": "China"
},
{
    "fruit_name": "Peach",
    "size": "Medium",
    "color": "Orange",
    "major_producer": "China"
},
{
    "fruit_name": "Pear",
    "size": "Medium",
    "color": "Yellow",
    "major_producer": "China"
},
{
    "fruit_name": "Plum",
    "size": "Small",
    "color": "Purple",
    "major_producer": "China"
},
{
    "fruit_name": "Mango",
    "size": "Medium",
    "color": "Orange",
    "major_producer": "India"
},
{
    "fruit_name": "Cherry",
    "size": "Small",
    "color": "Red",
    "major_producer": "United States"
},
{
    "fruit_name": "Lemon",
    "size": "Small",
    "color": "Yellow",
    "major_producer": "Spain"
},
{
    "fruit_name": "Kiwi",
    "size": "Small",
    "color": "Green",
    "major_producer": "New Zealand"
}]
;



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

