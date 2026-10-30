import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class FR55SimpleWatchApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
        return [ new FR55SimpleWatchView() ];
    }
}
