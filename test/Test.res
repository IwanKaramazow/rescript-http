/* SimpleRequest.simple(); */
/* SimpleRequest.simpleCanceled(); */

SequentialRequest.sequential(
  ~resolve=data => {Js.log2("seq data", data)},
  ~reject=_ => {Js.log("failed")},
  (),
)

// Simple single Request
// Multiple requests in parallel and wait for all results (Promise.all)
// Sequential requests one after another (Promise.then)
// Race (cancel others when first succeeds)
