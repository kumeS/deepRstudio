#' Translate Selected Text to Portuguese via DeepL API
#'
#' This function uses the rstudioapi to execute Portuguese translation of the selected text using the DeepL API.
#' It will attempt to auto-detect the language of the text and translate it into Portuguese.
#' First, select the text and execute "DeepL Translation into Portuguese" from addins.
#' As a result, the selected part will be translated into Portuguese.
#'
#' @title Translate Selected Text to Portuguese via DeepL API
#' @description Translate the selected text in RStudio into Portuguese using the DeepL API with auto-detection of the source language.
#'    This function uses free-version DeepL API (https://api-free.deepl.com/v2/translate).
#' @importFrom rstudioapi isAvailable getActiveDocumentContext insertText
#' @importFrom assertthat assert_that
#' @return A message indicating the completion of the translation.
#' @author Satoshi Kume
#' @examples
#' \dontrun{
#'
#' #Select the following text: "La selección está traducida al inglés."
#' #Then, execute "DeepL Translation into Portuguese" from RStudio addins.
#'
#' }

deepel_rstudioapi_2PT <- function(){

  assertthat::assert_that(rstudioapi::isAvailable())

  # Get the selected text
  txt = rstudioapi::getActiveDocumentContext()$selection[[1]]$text

  # Translate into Portuguese
  res <- deepel(input = txt,
                target_lang = 'PT',
                Auth_Key = Sys.getenv("DeepL_API_KEY"),
                free_mode = TRUE)$text

  # Replace the selected text
  rstudioapi::insertText(text = as.character(res))
  #return(message("Finished!!"))

}

