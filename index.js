var gallery = null, displayListing = null, thumbnailsListing = [
    'http://photos.geni.com/p13/91/f2/07/bb/5344483904b52481/img_7801_medium.jpg',
    'http://photos.geni.com/p13/8b/77/a3/9c/5344483904b52477/blackbeard4_medium.jpg',
    'http://photos.geni.com/p13/55/15/80/8c/5344483904b5247f/img_7803_medium.jpg',
    'http://photos.geni.com/p13/07/de/9e/93/5344483904b5247c/uromastyx_medium.jpg',
    'http://photos.geni.com/p13/87/c5/a7/01/5344483904b52475/waterdragon2_medium.jpg',
    'http://photos.geni.com/p13/45/9a/44/22/5344483904b52482/img_7798_medium.jpg'
];


function getLargeVersion(item) {
    return item.replace('medium', 'large');
}

$(function() {
    displayListing = $.map(thumbnailsListing, getLargeVersion);
    gallery = new Gallery(thumbnailsListing, displayListing, $('.thumbnails'), $('.display'));

    gallery.onReachBeginning = function(value) {
        $('.previous').toggle(!value);
    };
    gallery.onReachEnd = function(value) {
        $('.next').toggle(!value);
    };
    gallery.display(0);

    $('.previous').click($.proxy(gallery.previous, gallery));
    $('.next').click($.proxy(gallery.next, gallery));
});