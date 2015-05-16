

## Comparación de tratamientos
setwd("C:/Users/Toshiba/Desktop/R aplicacion/Graficos y Modelos Automaticos")
list.files()

## informacion utilizada en el analisis
data <- read.table ("data.txt", header=TRUE, sep="\t", dec=",")
str(data)

# Ordenando niveles
data[,"Grupo"] <- factor(data[,"Grupo"], levels=paste("A",1:100,sep=""))
nivel <- paste("A",1:100,sep="")
#View(data)

# Analisis en Subgrupos Control vs Tratamiento

source(file = "mult_ggplot2.R")
graf.subg <- function(i){
        
        d <- subset(data, data[,"Grupo"]==nivel[i])
        
        library(reshape)
        mdata <- melt(data = d, id=names(d)[3])
        mdata$variable <- factor(mdata$variable, levels=c("Control","Tratamiento"))        
        
        library(ggplot2)
        ## diag densidad
        g1 <- ggplot(mdata, aes(x=value, fill=variable))+
                geom_density(color="gray60",alpha=0.6) + 
                labs(x="", y="",fill=paste("Grupo", 
                                           substring(mdata[1,"Grupo"],1,1))) +
                xlim(c(min(mdata$value)-2,max(mdata$value)+2))+
                scale_fill_discrete(labels=c("Tratamiento","Control"))+
                theme(axis.text.y=element_blank(),axis.ticks.y=element_blank(),
                      axis.title.x=element_blank())
        ## diag cajas        
        g2 <- ggplot(mdata, aes(x=1, y=value, fill=variable))+
                geom_boxplot(outlier.colour = "red",color="gray50",width=0.5)+
                labs(y = paste("Subgrupo: ", nivel[i], sep=""), 
                     x = "", fill=paste("Grupo", 
                                        substring(mdata[1,"Grupo"],1,1)))+
                scale_fill_discrete(labels=c("Tratamiento","Control"))+
                ylim(c(min(mdata$value)-2,max(mdata$value)+2))+
                theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())+
                coord_flip()
        
        ## multiples graficos ggplot2
        list_graf <- list(g1,g2)
        png(filename = paste("Subgrupo ",nivel[i],".png",sep=""), 
            width = 500, height = 350, units = "px")
        print(mult_ggplot(list_graf,2,1))
        dev.off()
}

#num_graf <- 5
num_graf <- length(nivel)
sapply(1:num_graf, graf.subg)



dif.med.subg <- function(i){
        
        d <- subset(data, data[,"Grupo"]==nivel[i])        
        ## Prueba var iguales
        Control <- d[,"Control"]
        Tratamiento <- d[,"Tratamiento"]
        ig.var <- var.test(Control, Tratamiento)
        
        print(paste("Control y Tratamiento en Subgrupo:",nivel[i], sep=" "))
        print(ig.var)
        ## Rechazo var iguales
        var.igual <- TRUE
        if(ig.var$p.value<0.05) var.igual <- FALSE 
        ## Prueba medias muestras pequeñas, pareadas, var iguales o distintas
        ## desv estand poblacional desconocida
        dif.med <- t.test(Control, Tratamiento, alternative="greater", paired=TRUE,
                          var.equal=var.igual, conf.level=0.95)
        
        print(paste("Control y Tratamiento en Subgrupo:",nivel[i], sep=" "))
        print(dif.med)
}

num_tests <- 20
#num_tests <- length(nivel)
sapply(1:num_tests, dif.med.subg)

