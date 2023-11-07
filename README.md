# AirPollution-Analysis


# 𝑆𝑂 Concentrations in the U.S.
SPATIAL AND REGRESSION ANALYSIS

Data Description and Processing
The Study
This data gives air pollution and related values for 41 U.S. cities and were collected from U.S. government publications. The data are means over the years 1969-1971.
What is SO2?
SO2 is the chemical formula for a molecule called Sulfur Dioxide. It is a toxic gas responsible for the smell of burnt matches. Wikipedia SO2*
This study concerns the concentrations of Sulphur Dioxide in micrograms per cubic meter in the air. The reason for studying SO2 concentrations is because of the adverse implications on our health and the environment.
Short-term exposures to SO2 can harm the human respiratory system and make breathing difficult. People with asthma, particularly children, are sensitive to the effects of SO2.
SO2 that is emitted in high concentrations into the air generally also lead to the formation of other sulfur oxides (SOx). The following reaction is one of the ways in which sulfur dioxide can harm the environment.
𝑆𝑂2 + 1 𝑂2 → 𝑆𝑂3 2
This reaction occurs in the air and produces the gas sulfur trioxide which then allows for the following reaction to occur. Wikipedia*
𝑆𝑂3(𝑔) +𝐻2𝑂(𝑙) →𝐻2𝑆𝑂4(𝑎𝑞)
Where aq is an aqueous solution. This slow but sure process creates Sulfuric Acid in the air, which may lead to acid rain. This is an example of just one the ways Sulfur Dioxide can react in the air. https://www.epa.gov/so2-pollution*
SOx can react with other compounds in the atmosphere to form small particles. These particles contribute to particulate matter (PM) pollution. Small particles may penetrate deeply into the lungs and in sufficient quantity can contribute to health problems. https://www.epa.gov/so2-pollution*
   PAGE 2
Purpose of Our Study
The purpose of this data exploration is for two reasons, we will first look to see if it is possible to accurately predict the response given the variables with regard to the bias- variance trade off. Which is shown in the equation below,
'2''2
𝐸(𝑦0 − 𝑓(𝑥0)) = 𝑉𝑎𝑟(𝑓(𝑥0)) + [𝐵𝑖𝑎𝑠(𝑓(𝑥0))] + 𝑉𝑎𝑟(𝜖)
This expected value is the Mean Squared Error calculated from the test data. Because we can overfit training data quite easily, our test MSE is most important to us. For every model we create we will show the training and test MSE’s and variance of the model.
The next most important topic of study is what variables are most important to the response. For spatial analysis, we will consider whether spatial location is important to the response variable. For multiple linear regression, we will consider all of the variables and the 5 regions of the U.S.
