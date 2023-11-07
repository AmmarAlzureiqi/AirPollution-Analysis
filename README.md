# AirPollution-Analysis


# 𝑆𝑂 Concentrations in the U.S.
SPATIAL AND REGRESSION ANALYSIS

## Data Description and Processing

<ins>The Study</ins>

This data gives air pollution and related values for 41 U.S. cities and were collected from U.S. government publications. The data are means over the years 1969-1971.

<ins>What is SO2?</ins>

SO2 is the chemical formula for a molecule called Sulfur Dioxide. It is a toxic gas responsible for the smell of burnt matches. Wikipedia SO2*

<p align="center">
<img src='https://github.com/AmmarAlzureiqi/AirPollution-Analysis/assets/100096699/8ed7ead3-1351-4d68-8387-439edde01a73' width='150' height='200'>
</p>

This study concerns the concentrations of Sulphur Dioxide in micrograms per cubic meter in the air. The reason for studying SO2 concentrations is because of the adverse implications on our health and the environment.

Short-term exposures to SO2 can harm the human respiratory system and make breathing difficult. People with asthma, particularly children, are sensitive to the effects of SO2.

SO2 that is emitted in high concentrations into the air generally also lead to the formation of other sulfur oxides (SOx). The following reaction is one of the ways in which sulfur dioxide can harm the environment.

<p align="center">
<img src='https://github.com/AmmarAlzureiqi/AirPollution-Analysis/assets/100096699/8396011a-c075-46e9-b1e9-8c2f7ffe6870' width='250' height='150'>
</p>


This reaction occurs in the air and produces the gas sulfur trioxide which then allows for the following reaction to occur. Wikipedia*

<p align="center">
<img src='https://github.com/AmmarAlzureiqi/AirPollution-Analysis/assets/100096699/c1d70b68-2d52-45d0-b1f9-34b5da3d3ba0' width='400' height='150'>
</p>


Where aq is an aqueous solution. This slow but sure process creates Sulfuric Acid in the air, which may lead to acid rain. This is an example of just one the ways Sulfur Dioxide can react in the air. https://www.epa.gov/so2-pollution*

SOx can react with other compounds in the atmosphere to form small particles. These particles contribute to particulate matter (PM) pollution. Small particles may penetrate deeply into the lungs and in sufficient quantity can contribute to health problems. https://www.epa.gov/so2-pollution*

<ins>Purpose of Our Study</ins>

The purpose of this data exploration is for two reasons, we will first look to see if it is possible to accurately predict the response given the variables with regard to the bias- variance trade off. Which is shown in the equation below,

<p align="center">
<img src='https://github.com/AmmarAlzureiqi/AirPollution-Analysis/assets/100096699/c9bb5889-9ccd-4e41-8d5c-65a1473b1b57' width='650' height='150'>
</p>


This expected value is the Mean Squared Error calculated from the test data. Because we can overfit training data quite easily, our test MSE is most important to us. For every model we create we will show the training and test MSE’s and variance of the model.

The next most important topic of study is what variables are most important to the response. For spatial analysis, we will consider whether spatial location is important to the response variable. For multiple linear regression, we will consider all of the variables and the 5 regions of the U.S.
