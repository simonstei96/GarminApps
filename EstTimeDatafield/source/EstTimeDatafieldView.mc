import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class EstTimeDatafieldView extends WatchUi.SimpleDataField {
    //Estimated time need for given distance
    private var mLastEstTime as Number;

    // Set the label of the data field here.
    function initialize() {
        WatchUi.SimpleDataField.initialize();
        label = "Est. run time";
        mLastEstTime = 0;
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Duration or Numeric or String or Null{
        // See Activity.Info in the documentation for available information.
        try{
            //Null check!
            //in meter
            var elapsedDistance = info.elapsedDistance != null ? info.elapsedDistance : 0.0;
            //in meter per second (m/s)
            var currentSpeed = info.currentSpeed != null ? info.currentSpeed : 0.0;
            //in milliseconds (ms)
            var elapsedTime = info.elapsedTime != null ? info.elapsedTime : 0;
            //in meter (for test use 10 kilometer)
            var completeDistance = 1000 * Application.Properties.getValue("runDistance"); 

            //Calculate estimated time to finish the given set distance of the run (race)
            //in meter
            var remainingDistance = completeDistance - elapsedDistance;
            if(remainingDistance > 0 && currentSpeed > 0){
                //in seconds
                var remainingEstTime = remainingDistance / currentSpeed;
                //in milliseconds
                mLastEstTime = elapsedTime + (remainingEstTime.toNumber() * 1000);
            }
            if(currentSpeed > 0){
                return new Time.Duration(mLastEstTime/1000);
            }else{
                return "-:--";
            }
        }catch(ex){
            return "-:--";
        }
    }
}