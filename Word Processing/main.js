const fs=require('fs');

const lines=fs.readFileSync('words.txt', 'utf-8');
const words=lines
    .split('\n')
    .filter(e=>!e.endsWith('s')); //ignore plural

const three=words.filter(word=>word.length===3); //3 is min. 2 is empty.
const four=words.filter(word=>word.length===4);
const five=words.filter(word=>word.length===5);
const six=words.filter(word=>word.length===6); //6 is max. 7 is empty.

exportToStruct('three', three);
exportToStruct('four', four);
exportToStruct('five', five);
exportToStruct('six', six);

function head(list) {
    console.log(list.slice(0, 5));
}

function exportToStruct(name, list) {
    console.log(`static let ${name} = [${list.map(e=>`"${e}"`).join(', ')}]`);
}

