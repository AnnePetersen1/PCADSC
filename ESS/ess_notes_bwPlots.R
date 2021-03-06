#Load data
data <- read.csv("P:/PCADSC/data/ESS/ESS6.csv",
                 na.strings = c(".", ".c", ".d", ".b"))

useVars <- c("cntry", "stflife", "happy", "fltsd", "fltdpr", "enjlf", "wrhpp", "fltanx",
             "fltpcfl", "dclvlf", "lchshcp", "accdng", "tmimdng", "tmabdng",
             "tmendng","dngval", "sedirlf", "optftr", "lotsgot", "pstvms", "flrms",
             "wrbknrm", "deaimpp", "flteeff", "slprl", "cldgng", "enrglot", "ppltrst",
             "pplfair", "pplhlp", "pplahlp", "flclpla", "inprdsc", "flapppl", "rehlppl",
             "fltlnl")

nAllDK <- nrow(data[data$cntry == "DK", ])
nAllBG <- nrow(data[data$cntry == "BG", ])
nAllSE <- nrow(data[data$cntry == "SE", ])
#anData <- na.omit(data[data$cntry %in% c("DK", "BG"), useVars])
anData <- na.omit(data[data$cntry %in% c("DK", "SE"), useVars])


anData$cntry <- as.character(anData$cntry)

sMat <- list()
sMat$var <- names(anData)[-1]
sMat$scale <- c(rep("Evaluative wellbeing", 2),
               rep("Emotional wellbeing", 6),
               rep("Functioning", 14),
               rep("Vitality", 4),
               rep("Community wellbeing", 5),
               rep("Supportive relationships", 4))


#Evaluative wellbeing
sapply(anData[, sMat$var[sMat$scale == "Evaluative wellbeing"]], range) #same number of levels
anData$EvaluativeWellbeing <- rowMeans(anData[, sMat$var[sMat$scale == "Evaluative wellbeing"]])

#Emotional wellbeing
sapply(anData[, sMat$var[sMat$scale == "Emotional wellbeing"]], range) #same number of levels
for (v in sMat$var[sMat$scale == "Emotional wellbeing"])  {
  anData[, v] <- anData[, v] - 1
}
for (v in c("fltsd", "fltdpr", "fltanx")) {
  anData[, v] <- 3 - anData[, v]
}
anData$EmotionalWellbeing <- (10/3)*rowMeans(anData[, sMat$var[sMat$scale == "Emotional wellbeing"]])

#Functioning
sapply(anData[, sMat$var[sMat$scale == "Functioning"]], range)
for (v in setdiff(sMat$var[sMat$scale == "Functioning"],
                  c("tmimdng", "tmabdng", "tmendng", "sedirlf", "deaimpp")))  {
  anData[, v] <- (anData[, v]-1)*2.5
}
for (v in c("dclvlf", "accdng", "dngval", "optftr", "lotsgot", "pstvms")) {
  anData[, v] <- 10 - anData[, v]
}
anData$Functioning <- rowMeans(anData[, sMat$var[sMat$scale == "Functioning"]])

#Vitality
sapply(anData[, sMat$var[sMat$scale == "Vitality"]], range)
for (v in sMat$var[sMat$scale == "Vitality"])  {
  anData[, v] <- anData[, v] - 1
}
for (v in c("flteeff", "slprl", "cldgng")) {
  anData[, v] <- 3 - anData[, v]
}
anData$Vitality <- (10/3)*rowMeans(anData[, sMat$var[sMat$scale == "Vitality"]])

#Community wellbeing
sapply(anData[, sMat$var[sMat$scale == "Community wellbeing"]], range)
anData$pplahlp <- (10/6)*anData$pplahlp
anData$flclpla <- 10 - ((10/4)*(anData$flclpla - 1))
anData$CommunityWellbeing <- rowMeans(anData[, sMat$var[sMat$scale == "Community wellbeing"]])

#Supportive relationships
sapply(anData[, sMat$var[sMat$scale == "Supportive relationships"]], range)
anData$inprdsc <- anData$inprdsc * (10/6)
anData$rehlppl <- anData$rehlppl * (10/6)
anData$fltlnl <- 10 - ((anData$fltlnl - 1) * (10/3))
anData$SupportiveRelationships <- rowMeans(anData[, sMat$var[sMat$scale ==
                                                               "Supportive relationships"]])

data_SEDK <- anData

anData <- na.omit(data[data$cntry %in% c("DK", "BG"), useVars])

anData$cntry <- as.character(anData$cntry)

sMat <- list()
sMat$var <- names(anData)[-1]
sMat$scale <- c(rep("Evaluative wellbeing", 2),
                rep("Emotional wellbeing", 6),
                rep("Functioning", 14),
                rep("Vitality", 4),
                rep("Community wellbeing", 5),
                rep("Supportive relationships", 4))


#Evaluative wellbeing
sapply(anData[, sMat$var[sMat$scale == "Evaluative wellbeing"]], range) #same number of levels
anData$EvaluativeWellbeing <- rowMeans(anData[, sMat$var[sMat$scale == "Evaluative wellbeing"]])

#Emotional wellbeing
sapply(anData[, sMat$var[sMat$scale == "Emotional wellbeing"]], range) #same number of levels
for (v in sMat$var[sMat$scale == "Emotional wellbeing"])  {
  anData[, v] <- anData[, v] - 1
}
for (v in c("fltsd", "fltdpr", "fltanx")) {
  anData[, v] <- 3 - anData[, v]
}
anData$EmotionalWellbeing <- (10/3)*rowMeans(anData[, sMat$var[sMat$scale == "Emotional wellbeing"]])

#Functioning
sapply(anData[, sMat$var[sMat$scale == "Functioning"]], range)
for (v in setdiff(sMat$var[sMat$scale == "Functioning"],
                  c("tmimdng", "tmabdng", "tmendng", "sedirlf", "deaimpp")))  {
  anData[, v] <- (anData[, v]-1)*2.5
}
for (v in c("dclvlf", "accdng", "dngval", "optftr", "lotsgot", "pstvms")) {
  anData[, v] <- 10 - anData[, v]
}
anData$Functioning <- rowMeans(anData[, sMat$var[sMat$scale == "Functioning"]])

#Vitality
sapply(anData[, sMat$var[sMat$scale == "Vitality"]], range)
for (v in sMat$var[sMat$scale == "Vitality"])  {
  anData[, v] <- anData[, v] - 1
}
for (v in c("flteeff", "slprl", "cldgng")) {
  anData[, v] <- 3 - anData[, v]
}
anData$Vitality <- (10/3)*rowMeans(anData[, sMat$var[sMat$scale == "Vitality"]])

#Community wellbeing
sapply(anData[, sMat$var[sMat$scale == "Community wellbeing"]], range)
anData$pplahlp <- (10/6)*anData$pplahlp
anData$flclpla <- 10 - ((10/4)*(anData$flclpla - 1))
anData$CommunityWellbeing <- rowMeans(anData[, sMat$var[sMat$scale == "Community wellbeing"]])

#Supportive relationships
sapply(anData[, sMat$var[sMat$scale == "Supportive relationships"]], range)
anData$inprdsc <- anData$inprdsc * (10/6)
anData$rehlppl <- anData$rehlppl * (10/6)
anData$fltlnl <- 10 - ((anData$fltlnl - 1) * (10/3))
anData$SupportiveRelationships <- rowMeans(anData[, sMat$var[sMat$scale ==
                                                               "Supportive relationships"]])

data_BGDK <- anData

#Amount of missing information
nMissDK <- nAllDK - sum(data_BGDK$cntry == "DK")
nMissSE <- nAllSE - sum(data_SEDK$cntry == "SE")
nMissBG <- nAllBG - sum(data_BGDK$cntry == "BG")
pctMissDK <- nMissDK/nAllDK
pctMissSE <- nMissSE/nAllSE
pctMissBG <- nMissBG/nAllBG


#Summarize data
uVs <- c("EvaluativeWellbeing",
         "EmotionalWellbeing",
         "Functioning",
         "Vitality",
         "CommunityWellbeing",
         "SupportiveRelationships")
nU <- length(uVs)

m <- data.frame(var = uVs,
                Q1_DK = rep(NA, nU),
                M_DK = rep(NA, nU),
                Q3_DK = rep(NA, nU),
                Q1_BG = rep(NA, nU),
                M_BG = rep(NA, nU),
                Q3_BG = rep(NA, nU),
                Q1_SE = rep(NA, nU),
                M_SE = rep(NA, nU),
                Q3_SE = rep(NA, nU))

m[, "Q1_DK"] <-sapply(1:nU, function(x) quantile(data_BGDK[data_BGDK$cntry == "DK", uVs[x]], 0.25))
m[, "M_DK"] <-sapply(1:nU, function(x) quantile(data_BGDK[data_BGDK$cntry == "DK", uVs[x]], 0.5))
m[, "Q3_DK"] <-sapply(1:nU, function(x) quantile(data_BGDK[data_BGDK$cntry == "DK", uVs[x]], 0.75))
m[, "Q1_BG"] <-sapply(1:nU, function(x) quantile(data_BGDK[data_BGDK$cntry == "BG", uVs[x]], 0.25))
m[, "M_BG"] <-sapply(1:nU, function(x) quantile(data_BGDK[data_BGDK$cntry == "BG", uVs[x]], 0.5))
m[, "Q3_BG"] <-sapply(1:nU, function(x) quantile(data_BGDK[data_BGDK$cntry == "BG", uVs[x]], 0.75))
m[, "Q1_SE"] <-sapply(1:nU, function(x) quantile(data_SEDK[data_SEDK$cntry == "SE", uVs[x]], 0.25))
m[, "M_SE"] <-sapply(1:nU, function(x) quantile(data_SEDK[data_SEDK$cntry == "SE", uVs[x]], 0.5))
m[, "Q3_SE"] <-sapply(1:nU, function(x) quantile(data_SEDK[data_SEDK$cntry == "SE", uVs[x]], 0.75))

library(xtable)
xtable(m, digits = 2)

#Do PCADSC
library(PCADSC)
library(ggplot2)
library(gridExtra)
#library(grid)

#DK/BG
set.seed(123424)
a2 <- PCADSC(data_BGDK, "cntry",  c("EvaluativeWellbeing",
                                    "EmotionalWellbeing",
                                    "Functioning",
                                    "Vitality",
                                    "CommunityWellbeing",
                                    "SupportiveRelationships"))

fig6_CE <- CEPlot(a2) +
  scale_y_continuous(breaks = round(seq(-0.3, 0.5, 0.1),1), limits = c(-0.2, 0.5)) +
  theme(panel.border = element_blank(),
        axis.line=element_line(),
        plot.title = element_text(size = 11, hjust = -0.09)) +
  ggtitle("Cumulative difference in eigenvalues: BG - DK") +
  ylab("")
fig6_angle <- anglePlot(a2) +
  theme(panel.border = element_blank(),
        axis.line=element_line(),
        plot.title = element_text(size = 11, hjust = -0.03)) +
  ggtitle("PCs for DK") +
  ylab("") +
  scale_color_manual(values = c("black", "black"), guide = FALSE)

fig7_chroma <- chromaPlot(a2, useComps = 2:4) +
  theme(#panel.border = element_blank(),
    axis.line=element_line(),
    # plot.title = element_text(size = 11, hjust = -0.02),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()) +
  scale_x_discrete("", limits = rev(c("", "PC2", "PC3", "PC4", ""))) +
  scale_fill_grey("")

#ggsave(plot = grid.arrange(fig5_CE, fig5_angle, nrow = 2), file = "./article/PlosOne/Fig5.eps",
#       device = "eps", dpi = 400, width = 7, height = 8)

#ggsave(plot = fig6_chroma, file = "./article/PlosOne/Fig6.eps",
#       device = "eps", dpi = 400, width = 7, height = 4)


#ggsave(plot = fig5_CE, file = "P:/PCADSC/CSP/CEBGDK.pdf", width = 7, height = 5)
#ggsave(plot = fig5_angle, file = "P:/PCADSC/CSP/angleBGDK.pdf", width = 7, height = 5)
#ggsave(plot = fig6_chroma, file = "P:/PCADSC/CSP/chromaBGDK.pdf", width = 7, height = 5)

ggsave(plot = grid.arrange(fig6_CE, fig6_angle, nrow = 2),
       file = "P:/PCADSC/Symposium-tekst/Figure6bw.pdf",
             dpi = 400, width = 7, height = 8)

ggsave(plot = fig7_chroma,
       file = "P:/PCADSC/Symposium-tekst/Figure7bw.pdf",
       dpi = 400, width = 7, height = 4)


#DK/SE
set.seed(1234)
a1 <- PCADSC(data_SEDK, "cntry",  c("EvaluativeWellbeing",
                               "EmotionalWellbeing",
                               "Functioning",
                               "Vitality",
                               "CommunityWellbeing",
                               "SupportiveRelationships"))
fig8_CE <- CEPlot(a1) +
  scale_y_continuous(breaks = round(seq(-0.6, 0.6, 0.1),1), limits = c(-0.3, 0.3)) +
  theme(panel.border = element_blank(),
        axis.line=element_line(),
        plot.title = element_text(size = 11, hjust = -0.09)) +
  ggtitle("Cumulative difference in eigenvalues: DK - SE") +
  ylab("")

fig8_angle <- anglePlot(a1) +
  theme(panel.border = element_blank(),
        axis.line=element_line(),
        plot.title = element_text(size = 11, hjust = -0.03)) +
  ggtitle("PCs for SE") +
  ylab("")+
  scale_color_manual(values = c("black", "black"), guide = FALSE)

fig9_chroma <-
  chromaPlot(a1) +
  theme(#panel.border = element_blank(),
    axis.line=element_line(),
    # plot.title = element_text(size = 11, hjust = -0.02),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()) +
  scale_x_reverse("", breaks = 1:6, labels = paste("PC", 1:6, sep = ""))+
  scale_fill_grey("")

#+
# ggtitle("PCs for DK") +
#  ylab("")



#ggsave(plot = grid.arrange(fig7_CE, fig7_angle, nrow = 2), file = "./article/PlosOne/Fig7.eps",
#       device = "eps", dpi = 400, width = 7, height = 8)

#ggsave(plot = fig8_chroma, file = "./article/PlosOne/Fig8.eps",
#       device = "eps", dpi = 400, width = 7, height = 4)

#ggsave(plot = fig7_CE, file = "P:/PCADSC/CSP/CESEDK.pdf", width = 7, height = 5)
#ggsave(plot = fig7_angle, file = "P:/PCADSC/CSP/angleSEDK.pdf", width = 7, height = 5)
#ggsave(plot = fig8_chroma, file = "P:/PCADSC/CSP/chromaSEDK.pdf", width = 7, height = 5)

ggsave(plot = grid.arrange(fig8_CE, fig8_angle, nrow = 2),
       file = "P:/PCADSC/Symposium-tekst/Figure8bw.pdf",
       dpi = 400, width = 7, height = 8)

ggsave(plot = fig9_chroma,
       file = "P:/PCADSC/Symposium-tekst/Figure9bw.pdf",
       dpi = 400, width = 7, height = 4)

