// Typed into the console on the webpage https://web.stanford.edu/class/cs193p/common.words

let x=webpage contents.split('\n')
x=x.split('\n').map(x=>x.trim())
let maxSize = 0
let minSize = 99999
for (let i of x) {
    if (i.length>maxSize) {
        maxSize = i.length
    }
    else if (i.length < minSize && i.length != 0) {
        minSize = i.length
    }
}
console.log(minSize, maxSize)
// The answer is 3–6 characters long

