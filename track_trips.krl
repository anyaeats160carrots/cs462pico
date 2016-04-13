ruleset track_trips {
  meta {
    name "Track Trips"
    description <<single pico part 1>>
    author "Anna Sokolova"
    logging on
    sharing on
    provides process_trip
 
  }
  global {
 
  }
  rule process_trip {
    select when echo message
  pre{
    mileage = event:attr("mileage").klog("mileage: ");
  }
  {
    send_directive("trip") with
      trip_length = "#{mileage}";
  }
  }
}