.onLoad <- function(lib, pkg) {
  op <- options()
  op_apigpt <- list(
    apigpt.valid_api  = FALSE,
    apigpt.openai_key = NULL,
    apigpt.max_tokens = 500
  )

  toset <- !(names(op_apigpt) %in% names(op))
  if (any(toset)) options(op_apigpt[toset])


  invisible()
}

globalVariables(".rs.invokeShinyPaneViewer")

