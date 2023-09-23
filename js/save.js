// JavaScript to handle the Report button click
document.getElementById('report-button').addEventListener('click', function() {
    // Get the selected location and disaster
    const selectedLocation = document.getElementById('location').value;
    const selectedDisaster = document.getElementById('disaster').value;

    // Set the iframe source and link based on the selected location and disaster
    const iframeSrc = `https://www.openstreetmap.org/export/embed.html?bbox=...&layer=mapnik&marker=...`;
    const viewMapLink = `https://www.openstreetmap.org/?mlat=...&mlon=...#map=5/.../...`;

    // Update the iframe and link
    const mapIframe = document.getElementById('map-iframe');
    const viewLargerMapLink = document.getElementById('view-larger-map');

    mapIframe.src = iframeSrc;
    viewLargerMapLink.href = viewMapLink;

    // Show the map container
    const mapContainer = document.getElementById('map-container');
    mapContainer.style.display = 'block';

    // Show the "Thank you" message
    const thankYouMessage = document.getElementById('thank-you-message');
    thankYouMessage.style.display = 'block';
});
