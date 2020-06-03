
usethis::use_description(fields = list(
  # Package = "ppvsbp", # default, no need to specify
  Version = "0.1.0",
  Title = "A Comparison Between Precise And Bounded Probability To Quantify Epistemic Uncertainty In A Scientific
        Assessment",
  Description = "Code for paper: A comparison between precise and bounded
        probability to quantify epistemic uncertainty in a scientific
        assessment.", # at least one sentence
  `Authors@R` = 'c(person(given="Ivette", family="Raices Cruz",
                   email = "ivette.raices_cruz@cec.lu.se", role = c("aut", "cre")),
                   person("Dmytro", "Perepolkin",
                   email = "dperepolkin@gmail.com", role = c("aut", "ctb")),
                   person("Dmytro", "Perepolkin",
                   email = "dperepolkin@gmail.com", role = c("aut", "ctb"))
                   )',
  # Encoding = "UTF-8", # default, no need to specify
  # LazyData = "true" # default, no need to specify
  URL = "https://github.com/Iraices/PrecisePvsBoundedP",
  BugReports = "https://github.com/Iraices/PrecisePvsBoundedP/issues",
  Language =  "en", # insert new fields above this line,
  Depends = "R (>= 2.10)"
 )
)
usethis::use_gpl3_license("Ivette Raices Cruz")
#usethis::use_git()
#usethis::browse_github_pat()
#usethis::use_github()
#usethis::use_r("script")
usethis::use_package("HDInterval") # this is for specifying dependencies. Use instead of library(pkgname)
usethis::use_package("SHELF") # this is for specifying dependencies. Use instead of library(pkgname)
usethis::use_package("dplyr") # this is for specifying dependencies. Use instead of library(pkgname)
usethis::use_package("ggplot2") # this is for specifying dependencies. Use instead of library(pkgname)
usethis::use_package("tidyr") # this is for specifying dependencies. Use instead of library(pkgname)
usethis::use_package("dfoptim") # this is for specifying dependencies. Use instead of library(pkgname)
usethis::use_package("stats") # this is for specifying dependencies. Use instead of library(pkgname)
usethis::use_package("rlang") # this is for specifying dependencies. Use instead of library(pkgname)


#usethis::use_package_doc()
#usethis::use_readme_rmd()
#usethis::use_lifecycle_badge("Experimental")
#usethis::use_news_md()
#usethis::use_testthat()
#usethis::use_test()
#usethis::use_travis()
#usethis::use_appveyor()
#usethis::use_pkgdown()
#usethis::use_pkgdown_travis()
#usethis::use_coverage()
#and more
