import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';

// NORMAL MAP
const mapElement = document.getElementById('map');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
  const map = window.map = new GMaps({
    el: '#map',
    lat: 0,
    lng: 0,
    mapTypeControl: false,
    streetViewControl: false,
    fullscreenControl: false,
    zoomControl: true,
    zoomControlOptions: {
        position: google.maps.ControlPosition.TOP_RIGHT
    }
    });

  const cardsgrid = document.getElementById('cardspartial')
  const markers = JSON.parse(cardsgrid.dataset.markers);
  map.addMarkers(markers);
  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    map.setCenter(markers[0].lat, markers[0].lng);
    map.setZoom(14);
  } else {
    map.fitLatLngBounds(markers);
  }
}


// // MAP WITH OFFSET FOR MARKERS
// const fullMapElement = document.getElementById('full-page-map');
// if (fullMapElement) {
//   const map = new GMaps({
//     el: '#full-page-map',
//     lat: 0,
//     lng: 0,
//     mapTypeControl: false,
//     streetViewControl: false,
//     fullscreenControl: false,
//     zoomControl: true,
//     zoomControlOptions: {
//         position: google.maps.ControlPosition.TOP_RIGHT
//     }
//     });

//   const markers = JSON.parse(mapElement.dataset.markers);
//   map.addMarkers(markers);
//   if (markers.length === 0) {
//     map.setZoom(2);
//   } else if (markers.length === 1) {
//     map.setCenter(markers[0].lat, markers[0].lng);
//     map.setZoom(14);
//   } else {
//     map.fitLatLngBounds(markers);
//   }
// }

autocomplete();
