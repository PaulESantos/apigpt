#' Spanish spelling and grammar Addin
#'
#' Call this function as a Rstudio addin to ask GPT to improve spanish spelling and grammar of selected text.
#'
#' @export
spesgAddin <- function() {
  gpt_edit(
    model = "text-davinci-edit-001",
    instruction = "Improve the spelling and grammar of this text in  Peruvian Spanish.",
    temperature = .05
  )
}
