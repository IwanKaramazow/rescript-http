open Api

type cancel = unit => unit
let req1 = (~resolve, ~reject, ~onCancel=?, ()): cancel => {
  Js.log("req1 start...")
  let cancel = getBikes(~resolve, ~reject, ~onCancel?, ())

  () => {
    Belt.Option.forEach(onCancel, cb => cb())
    cancel()
  }
}

let req2 = (~resolve, ~reject, ~onCancel=?, ()): cancel => {
  Js.log("req2 start...")

  let cancel = getBikes(~resolve, ~reject, ~onCancel?, ())

  () => {
    Belt.Option.forEach(onCancel, cb => cb())
    cancel()
  }
}

// req: ~resolve, ~reject, ~onCancel => cancel

let sequential = (~resolve, ~reject, ~onCancel=?) => {
  let toCancel = []
  let addCancel = cancel => {
    Js.Array2.push(toCancel, cancel)->ignore
  }

  let resolve1 = data1 => {
    // req2

    let resolve2 = data2 => {
      Js.log2("data1", data1)
      Js.log2("data2", data2)
      let data = Js.Array2.concat(data1, data2)
      resolve(data)
    }

    req2(~resolve=resolve2, ~reject, ())->addCancel
  }

  let reject = ((code, msg)) => {
    Js.log2("code", code)
    Js.log2("msg", msg)
  }

  req1(~resolve=resolve1, ~reject, ())->addCancel

  let cancelAll = () => {
    Belt.Option.forEach(onCancel, cancel => {cancel()})
    Belt.Array.forEach(toCancel, cancel => {cancel()})
  }

  () => {
    cancelAll()
  }
}

// req1 -> req2
