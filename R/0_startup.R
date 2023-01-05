.onLoad <- function(lib, pkg) {
  op <- options()
  op.apigpt <- list(
    apigpt.valid_api = FALSE,
    apigpt.openai_key = NULL,
    apigpt.max_tokens = 500

  )

  toset <- !(names(op.apigpt) %in% names(op))
  if (any(toset)) options(op.apigpt[toset])

  invisible()
}

globalVariables(".rs.invokeShinyPaneViewer")
