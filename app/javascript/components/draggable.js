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
    const oldIndex = event.data.oldIndex;
    const newIndex = event.data.newIndex;

    if (newIndex > oldIndex) {
      var locationId = event.data.newContainer.children[newIndex + 1].attributes[1].value
    } else {
      var locationId = event.data.newContainer.children[newIndex].attributes[1].value
    }

    const tourId = window.location.pathname.split("/")[2];
    const URL = `/tours/${tourId}/locations/${locationId}`;

    fetch(URL, {
      method: 'put',
      body: JSON.stringify({"position": newIndex + 1}),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': Rails.csrfToken()
      },
      credentials: 'same-origin'
    })
      // .catch((response) => console.log(response.errors))
  })
}
export { initDraggable };

