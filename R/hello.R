# Hello, world!
#
# This is an example function named 'hello' 
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

#' Function title
#'
#' A description
#'
#' Details to be added
#'
#' @param x description of all parameters
#'
#' @note Further notes on how the function work and exceptions.
#' @return To appear as Value: the output
#' @examples
#' \donttest{
#' hello()
#' }
#' @export
hello <- function() {
  print("Hello, world!")
  1+1
}
