ruleset echo {
  meta {
    name "Echo"
    description <<
part 1 for lab single pico
>>
    author "Anna Sokolova"
    logging on
    sharing on
    provides hello
    provides message
 
  }
  global {
    hello = function(obj) {
      msg = "Hello " + obj
      msg
    };
    message = function(obj) {
      msg = "Input: " + obj
      msg
    };
 
  }
  rule hello {
    select when echo hello
    send_directive("say") with
      something = "Hello World";
  }
  rule message {
    select when echo message
  pre{
    input = event:attr("input").klog("passed in input: ");
  }
  {
    send_directive("say") with
      something = "Input: #{input}";
  }
  }
}