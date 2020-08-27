
#  ------------------------------------------------------------------------
#
# Title : Compile awesome-bootstrap CSS
#    By : Victor
#  Date : 2020-05-08
#
#  ------------------------------------------------------------------------



# Package -----------------------------------------------------------------

library(sass)




# CSS ---------------------------------------------------------------------


# From original file, prefix "awesome-" have been added to checkbox & radio classes to
# prevent conficts with Shiny base function
# padding was changed from from 20px to 5px


sass(
  input = list(

    sass_file(input = system.file(
      "assets/bootstrap-3.4.1/default/stylesheets/bootstrap/_variables.scss",
      package = "fresh"
    )),

    sass_file(input = system.file(
      "assets/bootstrap-3.4.1/default/stylesheets/bootstrap/_mixins.scss",
      package = "fresh"
    )),

    sass_file(input = "inst/assets/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.scss")

  ),
  options = sass_options(output_style = "compressed"),
  output = "inst/assets/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.min.css"
)

# after check icon content, there's a bug with unicode character (replace with \f00c)





