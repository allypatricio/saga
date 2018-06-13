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
    },
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
      map.addMarker({
        lat: e.latLng.lat(),
        lng: e.latLng.lng(),
        icon: {url: "https://raw.githubusercontent.com/Concept211/Google-Maps-Markers/master/images/marker_red.png"}
      });
      geocoder.geocode({'location': e.latLng}, createLocation);
    });
  }

  function createLocation(results, status) {
    if (status === "OK") {
      let address = results[0].formatted_address;
      const tourId = window.location.pathname.split("/")[2]
      let data = new FormData;
      data.append("location[address]", address)
      fetch(`/tours/${tourId}/locations/`, {
        method: 'post',
        body: data,
        headers: {
          // 'Content-Type': 'application/javascript',
          'X-CSRF-Token': Rails.csrfToken()
        },
        credentials: 'same-origin'
      })
      .then(response => response.json())
      .then((json) => {
        appendLocationBox(json.location);
        appendLocationModal(json.modal);
        colorMarkers();
      })
    } else {
      console.log("No address found")
    }
  };
};

function appendLocationBox(input) {
  const locationList = document.getElementById("locations-list")
  locationList.insertAdjacentHTML("beforeend", input)
}

function appendLocationModal(input) {
  const locationModals = document.getElementById("location-modals")
  locationModals.insertAdjacentHTML("beforeend", input)
}



createMap(mapStandard || mapFiltered || mapMarkers);
autocomplete();
