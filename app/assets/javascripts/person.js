function sortTable(column) {
  const table = document.getElementById('person_list');
  const tbody = table.querySelector('tbody');
  const rows = Array.from(tbody.querySelectorAll('tr'));
  rows.sort((a, b) => {
      const aValue = a.querySelector(`td[data-column="${column}"]`).textContent;
      const bValue = b.querySelector(`td[data-column="${column}"]`).textContent;
      return aValue.localeCompare(bValue);
  });

  rows.forEach(row => tbody.appendChild(row));
}

window.addEventListener('DOMContentLoaded', function () {
  const headers = document.querySelectorAll('th[data-column]');
  headers.forEach(header => {
    header.addEventListener('click', function () {
      const column = this.getAttribute('data-column');
      sortTable(column);
      if (header.getAttribute('data-column') === column) {
        header.classList.toggle('asc');
      } else {
        header.classList.remove('asc', 'desc');
      }
    });
  });
});

