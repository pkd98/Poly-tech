// 데이터 준비 (아래는 예시이며, 실제 JSON 객체는 여러분의 요구 사항에 따라 다를 것입니다)
let data = [];
for (let i = 0; i < 100; i++) {
    data.push({ id: i, name: `Name ${i}` });
}

let currentPage = 0;

function renderTable() {
    const table = document.getElementById('table');
    table.innerHTML = '';  // 테이블 내용을 비움
    let pageData = data.slice(currentPage * 10, (currentPage + 1) * 10);
    for (let item of pageData) {
        let row = document.createElement('tr');
        for (let key in item) {
            let cell = document.createElement('td');
            cell.textContent = item[key];
            row.appendChild(cell);
        }
        table.appendChild(row);
    }
}

function renderPagination() {
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';  // 페이징 내용을 비움
    for (let i = 0; i < Math.ceil(data.length / 10); i++) {
        let button = document.createElement('button');
        button.textContent = i + 1;
        button.addEventListener('click', function () {
            currentPage = i;
            renderTable();
        });
        pagination.appendChild(button);
    }
}

// 초기 렌더링
renderTable();
renderPagination();
