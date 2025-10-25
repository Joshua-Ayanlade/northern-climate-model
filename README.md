### 🎯 Project Overview
<p align="justify">
Accurate predicting the peak cooling demand is essential for designing energy-efficient air conditioning systems, especially in regions with extreme weather like Northern Nigeria. This project develops and provides Fourier series-based mathematical models that generate 24-hour profiles for:
</p>

- **Dry Bulb Temperature (Tdb)**
- **Relative Humidity (RH)**

<p align="justify">
The models are developed using 15 years of meterological data across 9 stations in Northern Nigeria (Yola, Bauchi, Maiduguri, Kaduna, Kano, Ilorin, Minna, Jos, and Sokoto) and can be used with two types of input:
</p>

- **Min/Max Inputs:** The minimum and maximum monthly average hourly values.
- **Raw Data Inputs:** Raw hourly data of a full month, from which the model computes the necessary averages.

---

### 🔬 Model Description
<p align="justify">
The prediction of hourly dry-bulb temperature and relative humidity distribution is based on a harmonic series (Fourier) analysis model used to approximate the diurnal variation.
The normalized hourly variation, $\Delta t$, is calculated as: </p>  

$$\Delta t(t) = a_0 + \sum_{n=1}^{N} [a_n \sin(\frac{n\pi t}{12}) + b_n \cos(\frac{n\pi t}{12})]$$  


where $t$ is the hour of the day (1 to 24) and $N=12$ is the number of harmonics. The coefficients ($a_0, a_n, b_n$) are parameter-specific constants embedded in the MATLAB functions which are gotten using the equations stated in our paper.

The final predicted hourly value ($X_{hourly}$) is then scaled using the monthly minimum average ($X_{min}$) and the monthly average range ($\text{Range} = X_{max} - X_{min}$):

$$X_{hourly} = (\Delta t \cdot \text{Range}) + X_{min}$$
</p>

---

### 📖 Functions
| Function | Input Type | Variable Predicted | Purpose |
| :--- | :--- | :--- | :--- |
| **`raw_monthly_input_model_Tdb`** | **Raw $N \times 24$ Matrix** | Dry-Bulb Temperature ($T_{db}$) | Calculates hourly $T_{db}$ distribution from raw monthly data. |
| **`raw_monthly_input_model_RH`** | **Raw $N \times 24$ Matrix** | Relative Humidity (RH) | Calculates hourly RH distribution from raw monthly data. |
| `min_max_model_Tdb` | Monthly $T_{min}$ and $T_{max}$ (Scalars) | Dry-Bulb Temperature ($T_{db}$) | Calculates hourly $T_{db}$ distribution using only monthly min/max averages. |
| `min_max_model_RH` | Monthly $RH_{min}$ and $RH_{max}$ (Scalars) | Relative Humidity (RH) | Calculates hourly RH distribution using only monthly min/max averages. |

---

### 💻 Usage Example
Below is a typical usage of the model functions:

```bash
clc; clear;

% EXAMPLE 1: Dry-bulb temperature prediction using Min/Max inputs
predicted_tdb_hourly_temp = min_max_model_Tdb(28.1900, 39.5700);
disp("Prediction for Tdb using Min/Max data:");
disp(predicted_tdb_hourly_temp);

% EXAMPLE 2: Dry-bulb temperature prediction using raw monthly data
% Input: 5 days x 24 hours of temperature data
data = [22.39,21.65,20.51,19.44,18.96,19.3,20.36,21.95,23.99,26.47,29.24,31.87,33.78,34.6,34.36,33.44,32.18,30.7,28.93,26.93,25.0,23.59,22.89,22.67;
        25.55,24.84,23.75,22.73,22.26,22.59,23.6,25.13,27.09,29.48,32.14,34.66,36.49,37.28,37.05,36.16,34.95,33.53,31.84,29.92,28.07,26.71,26.03,25.82;
        29.42,28.77,27.76,26.82,26.39,26.69,27.63,29.04,30.85,33.04,35.5,37.83,39.52,40.24,40.04,39.22,38.1,36.79,35.23,33.45,31.74,30.49,29.87,29.67;
        30.68,30.15,29.32,28.54,28.19,28.44,29.21,30.37,31.85,33.66,35.67,37.59,38.98,39.57,39.4,38.73,37.81,36.73,35.45,33.99,32.59,31.56,31.05,30.89;
        28.76,28.33,27.66,27.02,26.74,26.94,27.56,28.51,29.71,31.18,32.82,34.37,35.5,35.98,35.84,35.3,34.55,33.68,32.63,31.45,30.31,29.47,29.06,28.93;];

pred_temp = raw_monthly_input_model_Tdb(data);
disp("Prediction for Tdb using raw monthly data:");
disp(pred_temp);

% EXAMPLE 3: Relative humidity prediction using raw monthly data
% Input: 1 day x 24 hours of relative humidity data
rh_data = [41.43,42.32,43.08,44.13,45.47,46.31,45.46,42.23,37.08,31.36,26.42,22.86,20.48,18.87,18.15,18.87,21.38,25.3,29.56,33.09,35.52,37.2,38.69,40.17];

raw_monthly_input_model_RH(rh_data);
```

---

### 📊 Model Validation
As detailed in the paper, the model was validated against existing models. Mean Absolute Percentage Error of below 0.02% was achieved when compared with Olorunmaiye's Model, and model showed strong correlation with low Mean Forecast Error when compared with Kohli and Zong models.

---

### ✉️ Contact
K. H. Ibrahim  
Department of Mechanical Engineeering  
University of Ilorin, Nigeria.  
ibrahim.kh@unilorin.edu.ng  

---
📜 License

This project is licensed under the MIT License.
You are free to use, modify, and distribute with appropriate citation.
