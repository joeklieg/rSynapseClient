# Server side logging of exceptions encountered in the client
# 
# Author: brucehoff
#
# 
###############################################################################

logErrorToSynapse<-function(label, message) {
  logEntry<-LogEntry(label=paste(.userAgent(), label), message=message)
  synapsePost("/log",
    createListFromS4Object(logEntry), 
    anonymous = TRUE, 
    checkHttpStatus=FALSE
  )
}