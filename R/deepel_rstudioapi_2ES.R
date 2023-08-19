#' Translate Selected Text to Spanish via DeepL API
#'
#' This function uses the rstudioapi to execute Spanish translation of the selected text using the DeepL API.
#' It will attempt to auto-detect the language of the text and translate it into Spanish.
#' First, select the text and execute "DeepL Translation into Spanish" from addins.
#' As a result, the selected part will be translated into Spanish.
#'
#' @title Translate Selected Text to Spanish via DeepL API
#' @description Translate the selected text in RStudio into Spanish using the DeepL API with auto-detection of the source language.
#'    This function uses free-version DeepL API (https://api-free.deepl.com/v2/translate).
#' @importFrom rstudioapi isAvailable getActiveDocumentContext insertText
#' @importFrom assertthat assert_that
#' @return A message indicating the completion of the translation. No value is returned.
#' @author Satoshi Kume
#' @examples
#' \dontrun{
#'
#' #Select the following text: "La selección está traducida al inglés."
#' #Then, execute "DeepL Translation into Spanish" from RStudio addins.
#'
#' }

deepel_rstudioapi_2ES <- function(){

  assertthat::assert_that(rstudioapi::isAvailable())

  # Get the selected text
  txt = rstudioapi::getActiveDocumentContext()$selection[[1]]$text

  # Translate into Spanish
  res <- deepel(input = txt,
                target_lang = 'ES',
                Auth_Key = Sys.getenv("DeepL_API_KEY"),
                free_mode = TRUE)$text

  # Replace the selected text
  rstudioapi::insertText(text = as.character(res))
  return(message("Finished!!"))

}

