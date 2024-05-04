import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class EstTimeDatafieldView extends WatchUi.SimpleDataField {
    //Estimated time need for given distance
    private var mLastEstTime as Lang.Float;

    // Set the label of the data field here.
    function initialize() {
        WatchUi.SimpleDataField.initialize();
        label = "Est. race time";
        mLastEstTime = 0.0;
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        // See Activity.Info in the documentation for available information.

        //Null check!
        var elapsedDistance = info.elapsedDistance != null ? info.elapsedDistance : 0.0;
        var currentSpeed = info.currentSpeed != null ? info.currentSpeed : 0.0;
        var elapsedTime = info.elapsedTime != null ? info.elapsedTime : 0.0;
        var completeDistance = 10.0 * 1000; //In meter (for test use 10 kilometer)

        //Calculate estimated time to finish the given set distance of the run (race)
        var remainingDistance = completeDistance - elapsedDistance;
        if(remainingDistance < 0){
            var remainingEstTime = remainingDistance / currentSpeed;
            mLastEstTime = elapsedTime + remainingEstTime;
        }
        return mLastEstTime;
    }

}