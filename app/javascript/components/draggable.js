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
    console.log(oldIndex);
    console.log(newIndex);

    // Until here it works 100% as intended

    // const locationId = event.data.newContainer.children[newIndex].attributes[1].value;
    // const tourId = window.location.pathname.split("/")[2];
    // const URL = `/tours/${tourId}/locations/${locationId}`;
    // console.log(URL);
    // fetch(URL, {
    //   method: 'patch',
    //   body: JSON.stringify({location: {position: newIndex}}),
    //   // headers: {
    //   //   'Content-Type': 'application/json',
    //   //   'X-CSRF-Token': Rails.csrfToken()
    //   // },
    //   credentials: 'same-origin'
    // })
    // DONE fix url - oldIndex should be locationId
    // 2. use .then to check response (check frontend slides)
    // 3. if the JSON contains no errors (this means that the location was updated! see controller), refresh the page
    // 4. if the JSON does contain errors, refresh the page and show an error method
    // .then

  })
}
export { initDraggable };

