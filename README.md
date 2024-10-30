# **Hydrologic Prediction with UNet Model and Advanced Error Detection**  
*Machine Learning Internship Project at UC Irvine's Center for Hydrometeorology and Remote Sensing (CHRS)*

## **Project Overview**  
This repository includes my internship work focused on enhancing hydrologic prediction accuracy using a UNet model alongside an advanced error detection tool developed in MATLAB. Leveraging satellite datasets—microwave (**MW128**), infrared (**IR128**), and rainfall (**RAIN128**) imagery—this project optimizes data quality control and improves water resource management predictions.

### **Key Contributions**  
- **Data Pipeline Optimization**: Efficient loading and preprocessing of satellite imagery datasets, reducing preparation time and ensuring high-quality inputs for model training.  
- **UNet Model for Hydrologic Prediction**: Custom UNet architecture designed for satellite image segmentation, tailored to predict hydrologic patterns and trends.  
- **Advanced Error Detection Tool**: MATLAB-based tool for satellite image classification quality control, achieving a 35% improvement in prediction accuracy by reducing data noise.  
- **Performance Improvements**: Incorporates optimization techniques like learning rate scheduling and early stopping to boost model accuracy.  
- **Visual Analysis**: Visualizes model predictions, spatial data mappings, and performance metrics to provide a comprehensive view of predictive capabilities.

## **Project Structure**  
- **`UNET_Global01.ipynb`**: Main notebook with data loading, UNet model setup, training routines, and visual analysis.  
- **`processImages.m`**: MATLAB script implementing the error detection tool for satellite image classification, enhancing data quality and improving model prediction accuracy by 35%.  
- **`data/`**: Placeholder for satellite datasets (**MW128**, **IR128**, **RAIN128**).  
  *Note: Datasets are not included in this repository.*  
- **`results/`**: Placeholder for visual outputs and model results.  
  *Note: Results are not included in this repository.*

## **Datasets**  
- **MW128**: Microwave images, highlighting soil moisture and water content.  
- **IR128**: Infrared images, capturing temperature variations and surface details.  
- **RAIN128**: Rainfall data, supporting the study of precipitation patterns.

## **Model and Tool Details**  
- **UNet Model**  
  - **Input**: Multi-channel satellite images (MW, IR, and RAIN) at 128x128 resolution.  
  - **Layers**: Multiple convolutional and pooling layers for feature extraction, followed by upsampling layers for segmentation.  
  - **Output**: Predictions mapped to geospatial data for visual and practical applications.

- **Error Detection Tool**  
  - Developed in MATLAB for identifying and correcting errors in satellite classification data.  
  - Processes images to improve data quality, achieving a 35% increase in hydrologic prediction accuracy by minimizing data inconsistencies.

## **Visualizations and Results**  
- **Model Predictions**: Comparison of input images with predicted segmentation, showcasing the model’s hydrologic feature capture.  
- **Geospatial Mapping**: Visual representations overlaid on spatial maps to interpret predictions in geographic contexts.  
- **Performance Metrics**: Accuracy and loss curves show model performance over training epochs.

## **Technologies Used**  
- **Python & TensorFlow**: Core for model training and data manipulation.  
- **MATLAB**: Advanced error detection and data quality control.  
- **NumPy & Matplotlib**: Data manipulation and visualization.  
- **Basemap**: Geographic data visualization.

## **Acknowledgments**  
This project was completed during my Machine Learning Engineering Internship at CHRS, UC Irvine. Thanks to my mentors for their support and guidance.

## **Contact**  
For questions or collaboration, please reach out to *linhppham0104@gmail.com* or connect on *https://www.linkedin.com/in/evelynpham04/*.
