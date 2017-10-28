
Electroencephalography (EEG) technology has gained growing popularity in
various applications. In this project, I have made a deep learning based automated
system which can classify the workload on individuals into 3 categories - High Workload (HWL), Medium/Base Workload(BL) and Low (LWL)
using the Electroencephalographic signals (EEG) acquired by an inexpensive EEG
device (Emotiv EEG). Workload is a critical factor influencing the performance of
an individual in any field ranging from Research, corporate job to Army personels.
Here, a 14 channel EEG was used to acquire the brain signals while the
subjects were given some tasks to perform which were divided based on the
workload they can cause on an individual. The then acquired signals were passed
through a resilient Backpropogation Neural Network as training sets. The trained Neural Network
is then used for classification of workload on an individual by
just acquiring the EEG signals of that individual and pass them through the Network.

HOW TO TEST THIS MODEL: 
- Download server.R, ui.R and TRAINING_DATASET_CSV.csv in one folder.
- Open server.R (or ui.R) in R Studio, and Run the app.
- Once started, browse and upload the TRAINING_DATASET_CSV.csv(or your own dataset of EEG values, with workload classified).
- The Artificial Neural Network will be trained based on the training dataset provided. 
- Next, enter the EEG values for which you want to predict the Workload Category. By default, values have been entered. You can enter your   own too.
- Hit 'Run Analysis'
