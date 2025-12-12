# TO RUN THIS
# You need the libraries listed below.
# If you run "devbox shell" on pompano, it will automatically install them for you.
# Then run:
#
# source('IsrealTuna_99CI.R')   
# sic, i know Israel is spelled with 'a' before 'e', it was that way when i got here!
#
# note, file f512404800.RData gets an error, so put it into the folder named junk/ to skip
#
# move the files that have been successfully processed to done/
# this will save you from needlessly re-running them

#----Load Libraries----

library(runjags)
library(rjags)
library(adehabitatHR)
library(writexl)

#----Set Working Directory----

fdir = "/home/jeg/Israel-Tuna-jeg"


setwd(fdir)

#----Get List of File Names----


# data/ssm is a link to mola, so we cannot easily put raw_output into data/ssm.
# instead, we make a normal dir, called data/raw_output,
# which contains copies of select files from mrcastle@sherlock:bathy/output

files <- list.files("data/raw_output/",pattern = "\\.RData$")

browser()

#----Loop Through Files----

# Load File
for (i in 1:length(files)) {
  
  print(i)
  
  load(capture.output(cat("data/raw_output/",files[i],sep = "")))
  
  # Extract Posterior Distribution
  xxx <- as.mcmc.list(fit$mcmc,vars='x') # Markov Chain Monte Carlo (MCMC) output
  aaa <- as.array(xxx)
  
  nLocations <- dim(aaa)[2]/2 # Number of Locations
  
  lon <- aaa[,1:nLocations,] # Longitude of Posterior Distributions
  lat <- aaa[,-(1:nLocations),] # Latitude of Posterior Distributions
  
  rm(xxx)
  rm(aaa)
  
  date <- fit$summary$date # Dates 
  
  ind <- format(as.POSIXct(date), format = "%H") == "05" # Only Keep Locations from 05:00
  lon <- lon[,ind,]
  lat <- lat[,ind,]
  date <- date[ind]
  
  rm(ind)
  
  # 99% CI for all day (prevents gaps)
  xy <- cbind(as.vector(lon),as.vector(lat))
  xysp <- SpatialPoints(xy)
  
  rm(xy)
  
  kud <- kernelUD(xysp, grid=100, extent=0.5, h="href")
  tmp <- getverticeshr(kud,99)
  
  CI <- data.frame(tmp@polygons[[1]]@Polygons[[1]]@coords)
  
  rm(xysp)
  rm(kud)
  rm(tmp)
  
  write_xlsx(CI, path = capture.output(cat("./data/raw_output/",as.character(fit$summary$id[1]),"_99CI_full.xlsx",sep = "")), col_names = FALSE)
  
  rm(CI)
  
  rm(fit)
  rm(lon)
  rm(lat)
  rm(date)
}
rm(i)
rm(files)
