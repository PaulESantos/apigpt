#' Translate to Spanish Addin
#'
#' Call this function as a Rstudio addin to translate selected text to Spanish.
#'
#' @export
tspeAddin <- function() {
  check_api_connection()
  selection <- rstudioapi::selectionGet()

  edit <- openai::create_edit(
    model = "text-davinci-edit-001",
    input = selection$value,
    instruction = "Translate to Peruvian Spanish.",
    temperature = .05,
    top_p = 1,
    openai_api_key = Sys.getenv("OPENAI_API_KEY"),
    openai_organization = NULL
  )

  rstudioapi::insertText(edit$choices[1,1])


}
