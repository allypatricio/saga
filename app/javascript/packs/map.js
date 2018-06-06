import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';

// NORMAL MAP
const mapStandard = document.getElementById('map');
const mapFiltered = document.getElementById('cardspartial')
const mapMarkers = document.getElementById('map-markers')

function createMap(mapElement) {
  const map = window.map = new GMaps({
    el: "#"+mapElement.id,
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

  if (document.getElementById('cardspartial')) {
    var mapElement = document.getElementById('cardspartial');
  } else if (document.getElementById('map-markers')){
    var mapElement = document.getElementById('map-markers');
  } else {
    var mapElement = document.getElementById('map');
  }

  const markers = JSON.parse(mapElement.dataset.markers);
  map.addMarkers(markers);
  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    map.setCenter(markers[0].lat, markers[0].lng);
    map.setZoom(14);
  } else {
    map.fitLatLngBounds(markers);
  }
};

createMap(mapStandard || mapFiltered || mapMarkers)


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
