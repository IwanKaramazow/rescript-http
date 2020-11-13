open Api
let simple = () => {
  let resolve = data => {
    Js.log(data)
  }
  let reject = ((code, msg)) => {
    Js.log2("code", code)
    Js.log2("msg", msg)
    ()
  }

  let onCancel = () => {
    Js.log("request canceled")
  }

  Js.log("simpleRequest start...")
  let _ = getBikes(~resolve, ~reject, ~onCancel, ())
}

let simpleCanceled = () => {
  let resolve = data => {Js.log(data)}
  let reject = ((code, msg)) => {
    Js.log2("code", code)
    Js.log2("msg", msg)
    ()
  }

  let onCancel = () => {
    Js.log("request canceled")
  }

  Js.log("simpleRequestCanceled start...")
  let cancel = getBikes(~resolve, ~reject, ~onCancel, ())
  cancel()
}
