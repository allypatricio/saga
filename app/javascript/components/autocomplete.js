function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var locationAddress = document.getElementById('location_address');

    if (locationAddress) {
      var autocomplete = new google.maps.places.Autocomplete(locationAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(locationAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
