ruleset track_trips2 {
  meta {
    name "Track Trips 2"
    description << Single pico Part 2>>
    author "Anna Sokolova"
    logging on
    sharing on
    provides process_trip
  }
  global {
      long_trip = 300
  }
  rule process_trip {
    select when car new_trip
    pre{
      mileage = event:attr("mileage").klog("mileage: ");
    }

    { 
    send_directive("trip") with trip_length = "#{mileage}";
    }
    
  }

  rule find_long_trips {
    select when explicit trip_processed
    pre{
      mileage = event:attr("mileage").klog("mileage: ");
    }
    noop();
    fired{
      raise explicit event found_long_trip if (mileage > long_trip)
      always{
        log ("fired ent found_long_trip");
      }
    }
  }
  rule found_long_trip {
    select when explicit found_long_trip
    noop();
  }
}