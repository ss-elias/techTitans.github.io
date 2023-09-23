const apiKey = '5b3ce3597851110001cf62481298f862f55a401186e69df725a1137a';

// Define the base API URL
const apiUrl = 'https://api.openrouteservice.org/v2/directions/driving-car';

// Initialize the map
const map = L.map('map').setView([0, 0], 13);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

// Handle form submission
const form = document.getElementById('route-form');
form.addEventListener('submit', (e) => {
    e.preventDefault();
    calculateRoute();
});

function calculateRoute() {
    const start = document.getElementById('start').value;
    const end = document.getElementById('end').value;

    axios
        .get(`${apiUrl}?api_key=${apiKey}&start=${start}&end=${end}`)
        .then((response) => {
            const route = response.data.features[0].geometry.coordinates;
            const polyline = L.polyline(route, { color: 'blue' }).addTo(map);
            map.fitBounds(polyline.getBounds());
        })
        .catch((error) => {
            console.error('Error:', error);
        });
}