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
    console.log(URL);

    // console.log(JSON.stringify({position: newIndex}))
    // Until here it works 100% as intended
    fetch(URL, {
      method: 'patch',
      body: JSON.stringify({"position": newIndex}),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': Rails.csrfToken()
      },
      credentials: 'same-origin'
    })

    // DONE fix url - oldIndex should be locationId
    // 2. write proper fetch to patch locationId (fix 400 Bad Request)
    // 3. use .then to check response (check frontend slides)
    // 4. if the JSON contains no errors (this means that the location was updated! see controller), refresh the page
    // 5. if the JSON does contain errors, refresh the page and show an error method
    // .then

  })
}
export { initDraggable };

