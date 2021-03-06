# tests for typed lists
# 
# Author: brucehoff
###############################################################################


unitTestEmptyTypedList<-function() {
  p<-synapseClient:::UserProfile(openIds=character(0))
  synapseClient:::createListFromS4Object(p)
}


unitTestTypedList<-function() {
  t<-synapseClient:::RowReferenceList()
  rr1<-RowReference(rowId=as.integer(1), versionNumber=as.integer(2))
  rr2<-RowReference(rowId=as.integer(2), versionNumber=as.integer(2))
  t[[1]]<-rr1
  t[[2]]<-rr2
  checkEquals(2, length(t))
  checkEquals(t[[1]], rr1)
  checkEquals(t[[2]], rr2)
  checkEquals(list(rr1, rr2), synapseClient:::getList(t))
  
  # test 'append'
  t<-synapseClient:::RowReferenceList()
  t[[1]]<-rr1
  t<-append(t, rr2)
  checkEquals(list(rr1, rr2), getList(t))
  t<-synapseClient:::set(t, list(rr1, rr2))
  checkEquals(list(rr1, rr2), getList(t))
  
  t<-synapseClient:::RowReferenceList(rr1, rr2)
  checkEquals(list(rr1, rr2), getList(t))
}

unitTestCreateTypedList<-function() {
  rr1<-RowReference(rowId=as.integer(1), versionNumber=as.integer(2))
  rr2<-RowReference(rowId=as.integer(2), versionNumber=as.integer(2))
  rr3<-RowReference(rowId=as.integer(3), versionNumber=as.integer(2))
  created<-synapseClient:::createTypedList(c(rr1, rr2, rr3))
  checkTrue(identical(synapseClient:::RowReferenceList(rr1, rr2, rr3), created))
}

unitTestAppendTwoLists<-function() {
  r<-synapseClient:::RowReferenceList()
  s<-synapseClient:::RowReferenceList(synapseClient:::RowReference(rowId=as.integer(1)), synapseClient:::RowReference(rowId=as.integer(2)))
  t<-append(r, s)
  checkEquals(length(t), length(r)+length(s))
}

unitTestAsTypedList<-function() {
  rr1<-RowReference(rowId=as.integer(1), versionNumber=as.integer(2))
  rr2<-RowReference(rowId=as.integer(2), versionNumber=as.integer(2))
  rr3<-RowReference(rowId=as.integer(3), versionNumber=as.integer(2))
  checkEquals(synapseClient:::RowReferenceList(rr1, rr2, rr3), synapseClient:::as.RowReferenceList(list(rr1, rr2, rr3)))
  checkEquals(synapseClient:::RowReferenceList(rr1, rr2, rr3), synapseClient:::as.RowReferenceList(c(rr1, rr2, rr3)))
}

