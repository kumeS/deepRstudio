#' Translate Selected Text to Indonesian via DeepL API
#'
#' This function uses the rstudioapi to execute Indonesian translation of the selected text using the DeepL API.
#' It will attempt to auto-detect the language of the text and translate it into Indonesian.
#' First, select the text and execute "DeepL Translation into Indonesian" from addins.
#' As a result, the selected part will be translated into Indonesian.
#'
#' @title Translate Selected Text to Indonesian via DeepL API
#' @description Translate the selected text in RStudio into Indonesian using the DeepL API with auto-detection of the source language.
#'    This function uses free-version DeepL API (https://api-free.deepl.com/v2/translate).
#' @importFrom rstudioapi isAvailable getActiveDocumentContext insertText
#' @importFrom assertthat assert_that
#' @return A message indicating the completion of the translation. No value is returned.
#' @author Satoshi Kume
#' @examples
#' \dontrun{
#'
#' #Select the following text: "La selección está traducida al inglés."
#' #Then, execute "DeepL Translation into Indonesian" from RStudio addins.
#'
#' }

deepel_rstudioapi_2ID <- function(){

  assertthat::assert_that(rstudioapi::isAvailable())

  # Get the selected text
  txt = rstudioapi::getActiveDocumentContext()$selection[[1]]$text

  # Translate into Indonesian
  res <- deepel(input = txt,
                target_lang = 'ID',
                Auth_Key = Sys.getenv("DeepL_API_KEY"),
                free_mode = TRUE)$text

  # Replace the selected text
  rstudioapi::insertText(text = as.character(res))
  #return(message("Finished!!"))

}

