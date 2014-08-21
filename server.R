library(shiny)

tscol <- function(tss,eps) {
    fcol <- rep("blue",ncol(tss))
    fcol[abs(tss[nrow(tss),]-10) > eps] <- "red"
    return(fcol)
}

shinyServer(function(input,output){
    
    tseries <- reactive({
        N <- input$N ;
        n <- input$n ;
        seqn <- 1:n ;
        series <- switch(input$dist,
            Normal = matrix(rnorm(n*N, mean=10, sd=10), nrow = n, ncol = N),
            Exponential = matrix(rexp(n*N, rate=1/10), nrow = n, ncol = N),
            Lognormal = matrix(rlnorm(n*N, meanlog=log(5*sqrt(2)), 
                                sdlog=sqrt(log(2))), nrow = n, ncol = N)
        )
        avgseries <- ts(apply(series,2,cumsum)/seqn)
        avgseries
    })
    
    output$plot <- renderPlot({
        tssim <- tseries()
        plot(tssim, plot.type="single", 
                xlab="Sample size", ylab="Estimate",
                main="True mean = 10", col=tscol(tssim,input$epsilon))
    })
    
    output$limit <- renderPrint({
        tssim <- tseries()
        table <- as.data.frame(tssim[nrow(tssim),])
        names(table) <- ""
        table
    })
})