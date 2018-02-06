
# Simulate Shiny session

mock_session <- function() {
  as.environment(list(
    sendInputMessage = function(inputId, message) {
      session$lastInputMessage = list(id = inputId, message = message)
    },
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    },
    sendInsertUI = function(selector, multiple,
                            where, content) {
      session$lastInsertUI <- list(selector = selector, multiple = multiple,
                                   where = where, content = content)
    },
    onFlushed = function(callback, once) {
      list(callback = callback, once = once)
    }
  ))
}
