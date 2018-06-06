import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';

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

  let geocoder = new google.maps.Geocoder;

  if (mapElement.id === "map-markers") {
    map.addListener('click', function(e) {
      map.addMarker({lat: e.latLng.lat(), lng: e.latLng.lng()});
      geocoder.geocode({'location': e.latLng}, createLocation);
    });
  }

  function createLocation(results, status) {
    if (status === "OK") {
      let address = results[0].formatted_address;
      const tourId = window.location.pathname.split("/")[2]
      fetch(`/tours/${tourId}/locations/`, {
        method: 'post',
        body: JSON.stringify({location: {address: address}}),
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': Rails.csrfToken()
        },
        credentials: 'same-origin'
      })
    } else {
      console.log("No address found")
    }

  };
};



createMap(mapStandard || mapFiltered || mapMarkers);
autocomplete();
