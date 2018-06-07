import { Sortable } from '@shopify/draggable';
import { sortableEvent } from '@shopify/draggable';
import { SortableSortedEvent } from '@shopify/draggable';

function initDraggable() {
  // console.log(Sortable);
  const sortable = new Sortable(document.querySelectorAll('#locations-list'), {
    draggable: '.location-box'
  });

  // sortable.on('sortable:stop', (evt) => console.log("oldIndex: " + evt.data.oldIndex, "newIndex: " + evt.data.newIndex));
  sortable.on('sortable:stop', (event) => {
    let oldIndex = event.data.oldIndex;
    let newIndex = event.data.newIndex;
    const tourId = window.location.pathname.split("/")[2]
    fetch(`/tours/${tourId}/locations/${oldIndex}`, {
      method: 'patch',
      body: JSON.stringify({location: {position: newIndex}}),
      // headers: {
      //   'Content-Type': 'application/json',
      //   'X-CSRF-Token': Rails.csrfToken()
      // },
      credentials: 'same-origin'
    })
    // 1. fix url - oldIndex should be locationId
    // 2. use .then to check response (check frontend slides)
    // 3. if the JSON contains no errors (this means that the location was updated! see controller), refresh the page
    // 4. if the JSON does contain errors, refresh the page and show an error method
    // .then

  })
}
export { initDraggable };

