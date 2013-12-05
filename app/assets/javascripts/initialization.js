var NERD = NERD || {};
var SUCCESS = "success"

$().ready(function() {
  NERD.SensorsIndex.init();
});

NERD.ErrorHandler = {
  showError: function(message) {
    alert(message);
  }
};
