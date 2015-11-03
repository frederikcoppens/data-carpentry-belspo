### This function checks that all the plot IDS occur in the survey file
### If all plots are found, the message 'TRUE' is returned,
### otherwise the function emits a warning, and returns 'FALSE'

check_plots <-  function (survey_file = "data/surveys.csv", 
                          plot_file = "data/plots.csv")
{
  
  ## load files
  srvy <- read.csv(file = survey_file, stringsAsFactors = FALSE)
  plts <- read.csv(file = plot_file, stringsAsFactors = FALSE)
  
  ## get unique plot_id
  unique_srvy_plots <-unique(srvy$plot_id)
  
  if (all(unique_srvy_plots %in% plts$plot_id)){
    message("Everything looks good.")
    return(TRUE)
  } else {
    warning("Something is wrong.")
    return(FALSE)
  }
  
}

check_plots()

survey_file <-  "data/surveys.csv"
plot_file <-  "data/plots.csv"

surveys <- read.csv(file = survey_file, stringsAsFactors = FALSE)
plots <- read.csv(file = plot_file, stringsAsFactors = FALSE)

nrow(surveys)
ncol(surveys)

dim(plots)

unique(surveys$species)

