#' spelling and grammar Addin
#'
#' Call this function as a Rstudio addin to ask GPT to improve spelling and
#' grammar of selected text.
#'
#' @export
spesgAddin <- function() {
  gpt_edit(
    model = "text-davinci-edit-001",
    instruction = "Improve Spanish spelling and grammar of this text",
    temperature = 0.1
  )
}
