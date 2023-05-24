const date = new Date();
const currentYear = date.getFullYear();
const hour = date.getHours();

console.log('Year ' + date.getFullYear());
console.log('Month ' + (date.getMonth() + 1));
console.log('Date ' + date.getDate());
console.log('Hours ' + date.getHours());
console.log('Minutes ' + date.getMinutes());
console.log('Seconds ' + date.getSeconds());

if (hour < 12) {
    alert('오전');
}

if (hour >= 12) {
    alert('오후');
}