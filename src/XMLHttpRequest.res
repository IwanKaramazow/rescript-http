type t
type response

@bs.new external make: unit => t = "XMLHttpRequest"
@bs.send
external addEventListener: (t, string, unit => unit) => unit = "addEventListener"

@bs.get external response: t => response = "response"
@bs.send external open_: (t, string, string) => unit = "open"
@bs.send external send: t => unit = "send"
@bs.send external abort: t => unit = "abort"

@bs.get external status: t => int = "status"
@bs.get external responseText: t => string = "responseText"
@bs.get external statusText: t => string = "responseText"

@bs.send external setRequestHeader: (t, string, 'a) => unit = "setRequestHeader"

@val @scope("JSON") external parseJson: response => Js.Json.t = "parse"
