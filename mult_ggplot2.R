mult_ggplot <- function(list_graf=NULL, fils=2, cols=2) {
        require(grid)
        # lista de los objetos ggplot
        plots <- list_graf
        numPlots <- length(plots)
                
        # creamos una matriz para construir la disposicion de graf
        dispos <- matrix(seq(1, fils*cols),ncol = cols,
                         nrow = fils, byrow = TRUE)
        if (numPlots==1) {
                print(plots[[1]])
        } else {
                # Seteamos una nueva pag
                grid.newpage()
                pushViewport(viewport(layout = grid.layout(nrow(dispos),
                                                           ncol(dispos))))
        
                # Graf cada plot en la correct pos
                for (i in 1:numPlots) {
                        # obtenemis pos i,j en matriz disposición
                        pos <- which(dispos == i, arr.ind = TRUE)
                        print(plots[[i]], vp = viewport(layout.pos.row = pos[1,1],
                                                        layout.pos.col = pos[1,2]))
                }
        }
}

#list_graf <- list(g1, g2, g3, g4)
#mult_ggplot(list_graf, fils=2,cols=2)