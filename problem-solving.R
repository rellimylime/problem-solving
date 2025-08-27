# install.packages("googlesheets4")


# 1. Tiny Example ---------------------------------------------------------

# Workbook link: tinyurl.com/eds214-tiny-problem

# Is it small enough to see all at once?
# Is it simple enough to solve by hand?
# Does it represent the problem?


# 2. Solve by Hand --------------------------------------------------------

# Answer in the workbook


# 3. Minimum Information --------------------------------------------------

# What is the list of variables you need to solve the problem for _one_ case?

# Sample_Date
# Chemical + concentration
# (window size)

# 4. Solution in a Function -----------------------------------------------

# Write a function that takes the minimum information as parameters

moving_average <- function(focal_date, dates, concentrations, win_size_weeks) {
  
  # Which dates are in the window
  is_in_window <- (dates > focal_date - (win_size_weeks / 2) * 7) * (dates < focal_date + (win_size_weeks / 2) * 7)
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  # Calculate the mean
  result <- mean(window_conc)
  
  return(result)
  
}

ca_ma_1990_04_05 <- moving_average(focal_date = as.Date("1990-04-05"),
                                   dates = tiny_problem$sample_date,
                                   conc = tiny_problem$ca,
                                   win_size_weeks = 9)

# 5. Verify Your Solution -------------------------------------------------

sheet_url <- "https://docs.google.com/spreadsheets/d/1X-SltNKUaZH0zVWSUkC8sUrrlhPEPAd-6tBmbcihCSw"
tiny_problem <- googlesheets4::read_sheet(sheet_url, sheet = "Group 8")
tiny_problem$sample_date <- as.Date(tiny_problem$sample_date)

ca_ma_once <- moving_average(focal_date = as.Date("1990-04-05"),
                             dates = tiny_problem$sample_date,
                             conc = tiny_problem$ca,
                             win_size_weeks = 9)

# Did it work? If not, what went wrong? Don't debug yet!


# 6. Apply the Function ---------------------------------------------------

# _How_ will you apply your function?

# Max wants to use sapply()

# Write your full solution

tiny_problem$calc_rolling <- sapply(
  tiny_problem$sample_date,
  moving_average,
  dates = tiny_problem$sample_date,
  conc = tiny_problem$ca,
  win_size_weeks = 9
)

# Did it work? If not, what went wrong? Don't debug yet! 
