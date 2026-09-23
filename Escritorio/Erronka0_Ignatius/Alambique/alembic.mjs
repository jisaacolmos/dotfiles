import fs from "fs";


const Materials = {
    INGREDIENTS:    0,
    CONTAINER:      1,
    ENERGY:         2,
    UNKNOWN:        3     
}

const inputFile         = "materials.txt";
const fileEncoded1      = "./data/ingredients_encoded.kao";
const fileEncoded2      = "./data/container_encoded.kao";
const fileEncoded3      = "./data/energy_encoded.kao";
const fileEncoded4      = "./data/unknown_encoded.kao";

const lnx1 = [
    'wGEsFPRPqNiQQhD6_qar53bhcY5DnxNgpygaRrrP-gW1',
    'IU8IM68vhtvn8TBdZW1oX2w7f3k2jiBbFO8zCN7HoVx1',
    '8FDFZr-PbF6vLXck83NotD5XRezbmpepLBEdERvMsKJ1',
    'cWDQ3qpLHckFqlrbKkTPwEKKpySjpskKWeYbDmpVwlG1'
];

//const lnx = '1JKsMvREdEBLpepmbzeRX5DtoN38kcXLv6FbP-rZFDF8';


// const strArray = Array.from(lnx);
// const lnxInverse = strArray.reverse().toString().replaceAll(",", "");

// console.log(lnxInverse);


let inputData;
let allMaterials;

try
{
    inputData = processInput(inputFile);
    //console.log(inputData);

    const ingredients = decodeFile(fileEncoded1);
    const container   = decodeFile(fileEncoded2);
    const energy      = decodeFile(fileEncoded3);
    const unknown     = decodeFile(fileEncoded4);
    //console.log(meadowIngredients);

    allMaterials = [ingredients, container, energy, unknown];

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

        text = await pause(processingIngredients, 500);
        console.log(text);

        text = await pause(showIngredients, 1000);
        console.log(text);

        const areCorrect = processIngredients(); 

        if (areCorrect)
        {
            text = await pause(verified, 2000);
            console.log(text);
        }
        else
        {
            throw new Error ("ERROR: The list of ingredients is not correct");
        }

        

        text = await pause(processingContainer, 500);
        console.log(text);

        text = await pause(showContainer, 1000);
        console.log(text);

        const isContainer = processContainer();

        if (isContainer)
        {
            text = await pause(verified, 2000);
            console.log(text);
        }
        else
        {
            throw new Error ("ERROR: The container is not correct");
        }

        text = await pause(processingEnergy, 500);
        console.log(text);

        text = await pause(showEnergy, 1000);
        console.log(text);

        const isEnergy = processEnergy();

        if (isEnergy)
        {
            text = await pause(verified, 2000);
            console.log(text);
        }
        else
        {
            throw new Error ("ERROR: The energy source is not correct");
        }

        text = await pause(processingUnknown, 500);
        console.log(text);

        text = await pause(showUnknown, 1000);
        console.log(text);

        const isUnknown = processUnknown();

        if (isUnknown)
        {
            text = await pause(verified, 2000);
            console.log(text);
        }
        else
        {
            throw new Error ("ERROR: The unknown material is not correct");
        }

        text = await pause(verificationDone, 2000);
        console.log(text);
        
        const strArray = Array.from(lnx1[2]);
        const code = strArray.reverse().toString().replaceAll(",", "");
        console.log(`ACTIVATION CODE: ${code}`);

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

function verificationDone()
{
    return "--------------------------\nVERIFICATION DONE\n--------------------------";
}


function processingIngredients()
{
    return "Processing ingredients...";
}

function verified()
{
    return "Verification: OK";
}

function processingContainer()
{
    return "Processing container...";
}

function processingEnergy()
{
    return "Processing energy source...";
}

function processingUnknown()
{
    return "Processing unknown material...";
}

function showIngredients()
{
    return {ingredients: inputData.ingredients};
}

function showContainer()
{
    return {container: inputData.container};
}

function showEnergy()
{
    return {energy_source: inputData.energy};
}

function showUnknown()
{
    return {unknown: inputData.unknown};
}



function processed()
{

    return "Finished processing";

}

function noText()
{
    return "";
}






function processIngredients()
{ 
    return verifyIngredients(inputData.ingredients, allMaterials[Materials.INGREDIENTS]);
    
}


function processContainer()
{
    return verifyIngredients(inputData.container, allMaterials[Materials.CONTAINER]);
}


function processEnergy()
{
    return verifyIngredients(inputData.energy, allMaterials[Materials.ENERGY]);
}


function processUnknown()
{
    return verifyIngredients(inputData.unknown, allMaterials[Materials.UNKNOWN]);
}




//Vemos si los nombres insertados están en la lista
function verifyIngredients(inputData, allIngredients)
{
    const ingredientList = allIngredients;

    const ingredientsFound = inputData.filter(inputIngredient => ingredientList.some(target => inputIngredient === target) );

    const allFound = ingredientsFound.length === inputData.length;

    return allFound;
                    
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
        //console.log(data);

        let remainingData = data;
        //console.log(remainingData);

        const dataTypes = ["Ingredients: ", "Container: ", "Energy: ", "Unknown: "];
        //console.log(dataTypes.length);
        const dataValues = [];
        
        
        for (let i = 0; i < dataTypes.length; ++i) 
        {
            // console.log("hola");
            // console.log(remainingData);
            //Extraemos cada dato
            let valueString = remainingData.substring(remainingData.indexOf(dataTypes[i]) + dataTypes[i].length, remainingData.indexOf("\n"));
            valueString = valueString.trim();
            const values = valueString.split(",");
            dataValues.push(values);
            remainingData = remainingData.substring(remainingData.indexOf("\n") + 1);
            //console.log(remainingData);

        }

        
        //console.log(dataValues);
        

        return {
            ingredients:    dataValues[0],
            container:      dataValues[1],
            energy:         dataValues[2],
            unknown:        dataValues[3]
            
        }
    }
    catch (e) 
    {
        //console.log(e);
        if (e.code === 'ENOENT')
        {
            throw new Error("Error: File materials.txt does not exist");
        }

        //console.log(e.message);
            
    }
        

}

