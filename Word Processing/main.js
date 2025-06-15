const fs=require('fs');
const pluralize=require('pluralize');
const compromise=require('compromise');

const lines=fs.readFileSync('words.txt', 'utf-8');
const words=lines
    .split('\n')
    .filter(word=>!pluralize.isPlural(word)) //ignore plural
    .filter(word=>!word.endsWith('ed')); //ignore past tense words

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
    console.log(`\tstatic let ${name}: [String] = [${list.map(e=>`"${e}"`).join(', ')}]`);
}

