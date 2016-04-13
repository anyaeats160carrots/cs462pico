ruleset trip_store {
  meta {
    name "Trip Store"
    description <<Single pico part 3>>
    author "Anna Sokolova"
    sharing on
    provides trips, long_trips, short_trips
  }
  
  global {
      trips = function(){
        trips;
      }
      long_trips = function(){
        long_trips;

      }
      short_trips = function(){
        short_trips = ent:trips.filter(function(k,v){ent:trips{k} != ent:long_trips{k}});
        short_trips;
      }
  }
  
  rule collect_trips {
    select when explicit trip_processed mileage "(.*)" setting (miles)
    fired{
      set ent:trip_store{time:now()} miles;
    }
  }

  rule collect_long_trips {
    select when explicit found_long_trip mileage "(.*)" setting (miles)
    fired{
      set ent:long_trip_store{time:now()} miles;
    }
  }
 
  rule clear_trips {
    select when car trip_reset
    always{
      clear ent:trip_store;
      clear ent:long_trip_store;
    }
  }
}