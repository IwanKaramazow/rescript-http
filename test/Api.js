// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "../node_modules/bs-platform/lib/es6/curry.js";
import * as Belt_Option from "../node_modules/bs-platform/lib/es6/belt_Option.js";

var Bike = {};

function getBikes(resolve, reject, onCancel, param) {
  var req = new XMLHttpRequest();
  req.addEventListener("load", (function (param) {
          var code = req.status;
          if (code !== 200) {
            return Curry._1(reject, [
                        code,
                        "Request failed"
                      ]);
          }
          var data = req.responseText;
          return Curry._1(resolve, JSON.parse(data));
        }));
  req.addEventListener("error", (function (param) {
          console.log(req.responseText);
          return Curry._1(reject, [
                      req.status,
                      "Request failed"
                    ]);
        }));
  req.open("GET", "/api/bikes");
  req.send();
  return function (param) {
    Belt_Option.forEach(onCancel, (function (cb) {
            return Curry._1(cb, undefined);
          }));
    req.abort();
    
  };
}

export {
  Bike ,
  getBikes ,
  
}
/* No side effect */
