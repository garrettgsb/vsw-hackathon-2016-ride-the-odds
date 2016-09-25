#--------------------------------------------------------------
#**************************************************************


rm(list=ls())

mydir<-c("C:/HACK/2016sept9","C:/HACK/2016sept16","C:/HACK/2016sept22")

arvt<-list(a=data.frame(),b=data.frame(),c=data.frame())

for(k in 1:length(mydir)){
  
setwd(mydir[k])

translink<-list.files()

agency<-read.table(translink[1],header=T,sep=",",quote="",row.names = NULL)
calendar<-read.table(translink[2],header=T,sep=",",dec=".",quote="",row.names = NULL)
calendarDates<-read.table(translink[3],header=T,sep=",",dec=".",quote="",row.names = NULL)
routes<-read.table(translink[4],header=T,sep=",",dec=".",quote="",row.names = NULL)
shapes<-read.table(translink[5],header=T,sep=",",dec=".",quote="",row.names = NULL)
stopTimes<-read.table(translink[6],header=T,sep=",",dec=".",quote="",row.names = NULL)
stops<-read.table(translink[7],header=T,sep=",",dec=".",quote="",row.names = NULL)
transfers<-read.table(translink[8],header=T,sep=",",dec=".",quote="",row.names = NULL)
trips<-read.table(translink[9],header=T,sep=",",dec=".",quote="",row.names = NULL)

#--------------------------------------------------------------

#all trips of bus 100
mybus<-trips[which(trips$trip_headsign=="100 MARPOLE"),]

#all stops of bus 100 on specified trip

atStop<-data.frame()
for(i in 1:nrow(mybus)){
routeStops<-stopTimes[which(stopTimes$trip_id==mybus$trip_id[i]),]
atStop<-rbind(atStop,routeStops[which(routeStops$stop_id==2231),])}

arvt[[k]]<-as.data.frame(atStop)}
  
#--------------------------------------------------------------

a<-as.POSIXlt(as.character(arvt$a$arrival_time), format="%H:%M:%S",tz="Canada/Pacific")
ta<-a[-which(is.na(a)==TRUE)]

b<-as.POSIXlt(as.character(arvt$b$arrival_time), format="%H:%M:%S",tz="Canada/Pacific")
tb<-b[-which(is.na(b)==TRUE)]

c<-as.POSIXlt(as.character(arvt$c$arrival_time), format="%H:%M:%S",tz="Canada/Pacific")
tc<-c[-which(is.na(c)==TRUE)]

temp<-c(ta[1],tb[1],tc[1])

mean(temp)

#--------------------------------------------------------------

arrivalTime<-as.POSIXlt(as.character(atStop$arrival_time), format="%H:%M:%S",tz="Canada/Pacific")
arrivalTime<-arrivalTime[-which(is.na(arrivalTime)==TRUE)]

mean(arrivalTime)

OverUnder<-difftime(arrivalTime,mean(arrivalTime),units = "secs")

format(.POSIXct(OverUnder,tz="GMT"), "%H:%M:%S")

OverUnder<-as.difftime(arrivalTime,mean(arrivalTime), tim=range(arrivalTime))

#--------------------------------------------------------------
#**************************************************************
#PING TRANSLINK API:

library(httr)
library(xml2)
library(XML)

APIkey<-"irP53NIt7s1rOIOrqjTF"

#Speed
response<-GET(url = paste("https://rtdsapi.translink.ca/rtdsapi/v1/AllLiveData?apikey=",APIkey,sep=""), 
               authenticate('','auth token', type = 'basic'))
res<-content(response, encoding = 'json')

#--------------------------------------------------------------
#**************************************************************

APIaddress<-"http://api.translink.ca/rttiapi/v1/"

#------------------
#Buses:

busNo<-"7196"

response<-xmlParse(paste(APIaddress,"buses/",busNo,"?apikey=",APIkey,sep=""))
busref<-xmlToList(response)
rm(response)
busref

#------------------
#Route:

routeNo<-busref$RouteNo

response<-xmlParse(paste(APIaddress,"routes/",routeNo,"?apikey=",APIkey,sep=""))
routeref<-xmlToList(response)
rm(response)
routeref

#------------------
#Stop Estimate:

stop<-"61293"
routeNo<-"010"
response<-xmlParse(paste(APIaddress,"stops/",stop,"/estimates?apikey=",
                         APIkey,"&count=3&timeframe=120&routeNo=",routeNo,sep=""))
stopref<-xmlToList(response)
rm(response)
stopref

#------------------
#Stops:

stops<-"stops/55612?"

response<-GET(url = paste(APIaddress,stops,"apikey=",APIkey,sep=""),
              authenticate('','auth token', type = 'basic'))
res<-content(response)


#Buses serving route 99:

routeNo<-"099"
response<-xmlParse(paste(APIaddress,"buses?apikey=",APIkey,"&routeNo=",routeNo,sep=""))
busref<-xmlToList(response)
rm(response)
busref

#--------------------------------------------------------------
#**************************************************************

library(ggmap)

busNo<-"8041"

windows()
#plot the  hybrid Google Maps basemap
map <- qmap("vancouver, bc", zoom=13, maptype = "hybrid")
#plot the crime points on top

while(TRUE) {
Sys.sleep(10)

response<-xmlParse(paste(APIaddress,"buses/",busNo,"?apikey=",APIkey,sep=""))
busref<-xmlToList(response)
Long<-as.numeric(busref$Longitude)
Lat<-as.numeric(busref$Latitude)
print(map + geom_point(aes(x = Long, y = Lat), color="red", size=3, alpha=0.5))

rm(response, busref)

}





#--------------------------------------------------------------
