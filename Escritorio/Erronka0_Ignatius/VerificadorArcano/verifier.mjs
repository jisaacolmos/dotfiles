import fs from "fs";


const Places = {
    MEADOW: 0,
    HERBAL: 1,
    SLOTH:  2,
    CREEK:  3    
}

const inputFile         = "ingredients.txt";
const fileKeywords      = "./data/keywords_encoded.kao";
const fileEncoded1      = "./data/angelos_leafy_meadow_encoded.kao";
const fileEncoded2      = "./data/ioniras_herbal_encoded.kao";
const fileEncoded3      = "./data/ignatius_sloth_encoded.kao";
const fileEncoded4      = "./data/latitas_vile_creek_encoded.kao";

const lnx1 = [
    'wGEsFPRPqNiQQhD6_qar53bhcY5DnxNgpygaRrrP-gW1',
    'IU8IM68vhtvn8TBdZW1oX2w7f3k2jiBbFO8zCN7HoVx1',
    'IotDYKoNvdQaHl1jWfwNFWFDxuVBSBMK6SITHBc_aPL1',
    'cWDQ3qpLHckFqlrbKkTPwEKKpySjpskKWeYbDmpVwlG1'
];




//console.log(lnxInverse);


let inputData;
let keywordList;
let allIngredients;

try
{
    inputData = processInput(inputFile);

    //console.log("Keywords:")
    keywordList = decodeFile(fileKeywords);
    //console.log(keywordList);

    //console.log("Leafy meadow:")
    const meadowIngredients1 = decodeFile(fileEncoded1);
    const meadowIngredients2 = decodeFile(fileEncoded2);
    const meadowIngredients3 = decodeFile(fileEncoded3);
    const meadowIngredients4 = decodeFile(fileEncoded4);
    //console.log(meadowIngredients);

    allIngredients = [meadowIngredients1, meadowIngredients2, meadowIngredients3, meadowIngredients4];


    execute();
}
catch (error)
{
    console.log(error.message);
} 



async function execute()
{
    try
    {
        console.log("ARCANE VERIFIER")
        console.log("---------------")

        
        let text;

        text = await pause(processing, 200);
        console.log(text);

        text = await pause(location, 2000);
        console.log(text);

        text = await pause(ingredients, 2000);
        console.log(text);

        text = await pause(processed, 3000);
        console.log(text);

        text = await pause(noText, 300);
        console.log(text);

        processIngredients();
        


        
        
        



    }
    catch (error)
    {
        console.log(error.message);
        
    }
}



async function pause(callback, time)
{
    return new Promise((resolve, reject) => 
        setTimeout(() => 
            resolve(callback()), time)
    );
}


function processing()
{

    return "Processing ...";

}

function processed()
{

    return "Finished processing";

}

function noText()
{
    return "";
}

function location()
{
    return {location: inputData.location};
}

function ingredients()
{
    return {ingredients: inputData.ingredients};
}




function processIngredients()
{ 
    const placeId = verifyIfIngredientsExistsIn(inputData, allIngredients);
    //console.log(placeId);

    const currentIngredientList = allIngredients[placeId];
    //console.log(currentIngredientList);

    const getSuccessedIngredients = (ingredients, keywords) => 
        ingredients.filter(ingredient => keywords.find(keyword => ingredient.indexOf(keyword) !== -1));

    const successedIngredients = getSuccessedIngredients(currentIngredientList, keywordList);
    //console.log(successedIngredients);

    console.log("Total of ingredients processed: " + inputData.ingredients.length);
    console.log("Total of ingredients needed: " + successedIngredients.length);

    if (inputData.ingredients.length > successedIngredients.length)
    {
        throw new Error ("There are too many ingredients on the list")
    }
    
    const numOfIngredientsFound = getNumberOfIngredientsFound(inputData.ingredients, successedIngredients);

    
    console.log("Total of successful ingredients found: " + numOfIngredientsFound);

    if (numOfIngredientsFound === successedIngredients.length)
    {
        //Hemos encontrado todos. 
        console.log("--------------------------");
        console.log("VERIFICATION DONE");
        console.log("--------------------------");
        
        const strArray = Array.from(lnx1[placeId]);
        const code = strArray.reverse().toString().replaceAll(",", "");
        console.log(`ACTIVATION CODE: ${code}`);


    }
    
}

function getNumberOfIngredientsFound(ingredientsToSearch, successedIngredients)
{
    const ingredientsFound =  successedIngredients.filter(successedIngredient => ingredientsToSearch.some(input => successedIngredient === input) );
    return ingredientsFound.length;

}


//Vemos si los nombres insertados están en la lista
function verifyIfIngredientsExistsIn(inputData, allIngredients)
{
    const placeId = inputData.location === "Ionira's herbal"        ? Places.HERBAL :
                    inputData.location === "Ignatius' sloth"        ? Places.SLOTH  :
                    inputData.location === "Latita's vile creek"    ? Places.CREEK  :
                    inputData.location === "Angelo's leafy meadow"  ? Places.MEADOW : -1;

    
    //console.log(placeId);

    if (placeId === -1) 
    {
        throw new Error ("ERROR: Input location does not exist");
        return false;
    }

    const ingredientList = allIngredients[placeId];

    //console.log(ingredientList);

    const ingredientsFound = inputData.ingredients.filter(inputIngredient => ingredientList.some(target => inputIngredient === target) );
    //console.log(ingredientsFound);
    const allFound = ingredientsFound.length === inputData.ingredients.length;

    if (!allFound) 
    {
        throw new Error ("ERROR: Some input ingredients are not in " + inputData.location);
        return false;
    }

    return placeId;

                    
}







function decodeNumbers(numbers)
{
    const totalData = [];
    let data = [];
    
    for (let i = 0; i < numbers.length; ++i)
    {
        if(numbers[i] != -1)
        {
            data.push(String.fromCharCode(numbers[i]));
        }
        else
        {
            totalData.push(data.toString().replaceAll(",", ""));
            data = [];
        }
        
    }

    return totalData;
    
}



function decodeFile(fileName)
{
    let stringData = fs.readFileSync(fileName, { encoding: "utf-8", flag: "r"});
    stringData = stringData.substring(1, stringData.length-1);
    const arrayData =  stringData.split(",");
    return decodeNumbers(arrayData);


}

function processInput(fileName)
{
    try
    {
        const data = fs.readFileSync(fileName, { encoding: "utf-8", flag: "r"});

        let location = data.substring(data.indexOf("Location: ") + "Location: ".length, data.indexOf("\n"));

        //Quitamos el salto de linea
        location = location.trim();

        let ingredientList = data.substring(data.indexOf("Ingredients: ") + "Ingredients: ".length, data.length);
        
        //Quitamos los posibles saltos de linea al final
        ingredientList = ingredientList.trim();

        const ingredients = ingredientList.split(",");
        

        return {
            location,
            ingredients
        }
    }
    catch (e) 
    {
        //console.log(e);
        if (e.code === 'ENOENT')
        {
            throw new Error("Error: File ingredients.txt does not exist");
            //console.log("Error: File ingredients.txt does not exist");
        }

        //console.log(e.message);
            
    }
        

}

