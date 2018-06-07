import { Sortable } from '@shopify/draggable';
import { sortableEvent } from '@shopify/draggable';
import { SortableSortedEvent } from '@shopify/draggable';

function initDraggable() {
  // console.log(Sortable);
  const sortable = new Sortable(document.querySelectorAll('#locations-list'), {
    draggable: '.location-box'
  });

  sortable.on('sortable:stop', (evt) => console.log("oldIndex: " + evt.data.oldIndex, "newIndex: " + evt.data.newIndex));

}
export { initDraggable };
