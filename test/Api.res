module Bike = {
  type t = {
    id: int,
    name: string,
    price: float,
  }

  @val @scope("JSON") external parseApiResponse: string => array<t> = "parse"
}

type data = array<Bike.t>

let getBikes = (~resolve: data => unit, ~reject, ~onCancel: option<unit => unit>=?, ()): (
  unit => unit
) => {
  open XMLHttpRequest
  let req = make()

  req->addEventListener("load", () => {
    switch req->status {
    | 200 =>
      let data = req->responseText
      resolve(data->Bike.parseApiResponse)
    | code => reject((code, "Request failed"))
    }
  })

  req->addEventListener("error", () => {
    Js.log(req->statusText)
    reject((req->status, "Request failed"))
  })

  req->open_("GET", "/api/bikes")
  req->send

  () => {
    Belt.Option.forEach(onCancel, cb => cb())
    req->abort
  }
}
