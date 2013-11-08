var NERD = NERD || {};
var SUCCESS = "success"

$().ready(function() {
    NERD.CamerasIndex.init();
    NERD.CameraEventsIndex.init();
    NERD.SensorsIndex.init();
});

NERD.ErrorHandler = {
    showError: function(message) {
        alert(message);
    }
};