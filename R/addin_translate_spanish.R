#' Translate to Spanish Addin
#'
#' Call this function as a Rstudio addin to translate selected text to Spanish.
#'
#' @export
tspeAddin <- function() {
  gpt_edit(
    model = "text-davinci-edit-001",
    instruction = "Translate to Peruvian Spanish.",
    temperature = .1
  )
}
