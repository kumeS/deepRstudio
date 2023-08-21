#' Translate Selected Text and Speak in Japanese via DeepL API and MacOS system
#'
#' @title Translate and Speak in Japanese
#' @description This function takes the selected text in RStudio, translates it into Japanese using the DeepL API, and then speaks the translated text using MacOS's speech system.
#' @importFrom assertthat assert_that
#' @importFrom rstudioapi isAvailable getActiveDocumentContext
#' @importFrom crayon black
#' @return A message indicating that the translation and speech process has finished.
#' @export deepel_rstudioapi_speakInJA
#' @author Satoshi Kume
#' @examples
#' \dontrun{
#' #Select the following text: "La selección está traducida al inglés."
#' #Then, execute "Translation and Speak in Japanese : deepRstudio" from RStudio addins.
#' }

deepel_rstudioapi_speakInJA <- function(){

  assertthat::assert_that(rstudioapi::isAvailable())
  assertthat::assert_that(is_mac())

  voices <- system("say -v \\?", intern = TRUE)
  a <- strsplit(voices, split="       |#")
  b <- data.frame(matrix(NA, nrow = length(a), ncol = 3))
  for(n in seq_len(length(a))){
    a1 <- a[[n]][a[[n]] != ""]
    a1[2] <- gsub(" ", "", a1[2])
    a1[3] <- gsub("^ ", "", a1[3])
    b[n,] <- a1
  }

  d <- b[grepl("JP$", b$X2),]

  if(any(d$X1 %in% "Kyoko")){
    H_AI_voices <- "Kyoko"
  }else{
    stop("No AI voice")
  }

  # Get the selected text
  txt = rstudioapi::getActiveDocumentContext()$selection[[1]]$text
  #txt = "Get the selected text"

  # Translate the selected text into Japanese
  res <- deepel(input = txt,
                target_lang = 'JA',
                Auth_Key = Sys.getenv("DeepL_API_KEY"),
                free_mode = TRUE)$text

  # Speak in Japanese
  rate <- 200
  system(paste0("say -r ", rate, " -v ", H_AI_voices, " '", res, "'"))

  return(message("Results via DeepL:\n", crayon::black(gsub("\n", "", res))))

}
